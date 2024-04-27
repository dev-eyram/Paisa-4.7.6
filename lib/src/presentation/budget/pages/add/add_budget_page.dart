import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sika_purse/main.dart';
// import 'package:sika_purse/src/data/budget/store_cats.dart';
import 'package:sika_purse/src/domain/category/entities/category.dart';
import 'package:sika_purse/src/presentation/recurring/page/add_recurring_page.dart';

import '../../../../core/common.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../widgets/sika_purse_big_button_widget.dart';
import '../../../widgets/sika_purse_text_field.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddBudgetPage extends StatefulWidget {
  const AddBudgetPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBudgetPage> createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  final budgetAmountCtr = TextEditingController();
  // final budgetLimitCtr = TextEditingController();
  Category? _selectedCategory;
  final bool _setAlert = true;
  final bloc = getIt.get<CategoryBloc>();
  double _amount = 0.00;
  // late final bool isAddCategory = widget.categoryId == null;

  // context.read<PhoneNumberBloc>()

  @override
  void dispose() {
    budgetAmountCtr.dispose();
    // budgetLimitCtr.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<CategoryBloc>(context);
    // final bloc = context.read<CategoryBloc>();
    // print(bloc);
  }

  setBudgetAmount({required String amount}) {
    if (double.tryParse(amount) != null) {
      _amount = double.parse(amount);
      _amount = double.parse(
        _amount.toStringAsFixed(2),
      );

      setState(() {
        // _amount = double.parse(amount);
        budgetAmountCtr.text = _amount.toString();
      });
    } else {
      _amount = 0.00;
      setState(() {
        budgetAmountCtr.text = "0.00";
      });
    }

    // print(
    //     "==========  BlocProvider   setBudgetAmount    ========== ${BlocProvider.of<CategoryBloc>(context).categoryBudget}");
  }

  setSelectedCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });

    BlocProvider.of<CategoryBloc>(context)
        .add(FetchCategoryFromIdEvent(_selectedCategory?.superId.toString()));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<CategoryBloc>(context)
  //       .add(FetchCategoryFromIdEvent(widget.categoryId));
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
      if (state is CategoryAddedState) {
        context.showMaterialSnackBar(
          "Budget added successfully",
          backgroundColor: context.primaryContainer,
          color: context.onPrimaryContainer,
        );
        BlocProvider.of<CategoryBloc>(context)
            .add(const UpdateCategoryBudgetEvent(false));
        context.pop();
      } else if (state is CategoryErrorState) {
        context.showMaterialSnackBar(
          state.errorString,
          backgroundColor: context.errorContainer,
          color: context.onErrorContainer,
        );
      }

      // else if (state is CategorySuccessState) {
      //   budgetController.text = state.category.budget.toString();
      //   budgetController.selection = TextSelection.collapsed(
      //     offset: state.category.budget.toString().length,
      //   );

      //   categoryController.text = state.category.name;
      //   categoryController.selection = TextSelection.collapsed(
      //     offset: state.category.name.length,
      //   );

      //   descController.text = state.category.description ?? '';
      //   descController.selection = TextSelection.collapsed(
      //     offset: state.category.description?.length ?? 0,
      //   );
      // }
    }, builder: (context, state) {
      return ScreenTypeLayout(
        mobile: Scaffold(
          appBar: context.materialYouAppBar("Add Budget"),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        // CategoryNameWidget(controller: budgetController),
                        const SizedBox(height: 16),
                        autoCompleteTextInput(
                          context: context,
                          amount: _amount,
                          onSelect: (amount) => setBudgetAmount(amount: amount),
                          onChange: (amount) => setBudgetAmount(amount: amount),
                        ),
                        const SizedBox(height: 16),
                        // CategoryDescriptionWidget(controller: budgetAmountCtr),
                        // const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Enable budget Alert'),
                            Switch(
                              value: _setAlert,
                              onChanged: (value) {
                                // setState(() {
                                //   _setAlert = value;
                                // });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SelectNonBudgetCategory(
                          onGetSelected: (value) => setSelectedCategory(value),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SikaPurseBigButton(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  if (_selectedCategory == null) {
                    context.showMaterialSnackBar(
                      "Select a category to add",
                      backgroundColor: context.primaryContainer,
                      color: context.onPrimaryContainer,
                    );
                    return;
                  }

                  BlocProvider.of<CategoryBloc>(context).add(
                    const UpdateCategoryBudgetEvent(true),
                  ); // For changing a category to budget <true>

                  BlocProvider.of<CategoryBloc>(context).add(
                    const AddOrUpdateCategoryEvent(false),
                  ); // For updating existing category not to create a new one <false>

                  BlocProvider.of<CategoryBloc>(context).categoryBudget =
                      _amount; // For setting the budget amount <double e.g: 200>

                  // print(budgetAmountCtr.text);
                  // print(budgetLimitCtr.text);
                  // print(_selectedCategory?.superId.toString());
                  // print(_setAlert);
                },
                title: "Add",
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CategoryNameWidget extends StatelessWidget {
  const CategoryNameWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SikaPurseTextFormField(
      controller: controller,
      hintText: "Budget",
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        TextInputFormatter.withFunction((oldValue, newValue) {
          try {
            final text = newValue.text;
            if (text.isNotEmpty) double.parse(text);
            return newValue;
          } catch (_) {}
          return oldValue;
        }),
      ],
      // onChanged: (value) =>
      //     BlocProvider.of<CategoryBloc>(context).categoryTitle = value,
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return "Enter budget amount";
        }
      },
    );
  }
}

class CategoryDescriptionWidget extends StatelessWidget {
  const CategoryDescriptionWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SikaPurseTextFormField(
      readOnly: true,
      controller: controller,
      hintText: "Enter Budget Limit",
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
        TextInputFormatter.withFunction((oldValue, newValue) {
          try {
            final text = newValue.text;
            if (text.isNotEmpty) double.parse(text);
            return newValue;
          } catch (_) {}
          return oldValue;
        }),
      ],
      // onChanged: (value) =>
      //     BlocProvider.of<CategoryBloc>(context).categoryDesc = value,
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return "Enter budget limit";
        }
      },
    );
  }
}

// class AutoCompleteTextInput extends StatefulWidget {
//   final double amount;
//   final Function(String) onSelect;
//   final Function(String) onChange;

//   const AutoCompleteTextInput(
//       {super.key,
//       required this.amount,
//       required this.onSelect,
//       required this.onChange});

//   @override
//   State<AutoCompleteTextInput> createState() => _AutoCompleteTextInputState();
// }

// class _AutoCompleteTextInputState extends State<AutoCompleteTextInput> {
//   @override
//   Widget build(BuildContext context) {
//     List<String> suggestons = [];

//     Future<bool> generateSuggestions({required double amount}) async {
//       List<String> newSuggestons = [];

//       // Subtract 20%
//       newSuggestons.add(
//         (amount * 0.8).toString(),
//       );

//       // Subtract 10%
//       newSuggestons.add(
//         (amount * 0.9).toString(),
//       );

//       // Add 10% more
//       newSuggestons.add(
//         (amount * 1.1).toString(),
//       );

//       // Add 20% more
//       newSuggestons.add(
//         (amount * 1.2).toString(),
//       );

//       setState(() {
//         suggestons = newSuggestons;
//       });
//       return true;
//     }

//     print("ACTUAL AMOUNT: $widget.amount");
//     // generateSuggestions(amount: widget.amount);
//     // print("ACTUAL SUGGESTIONS: $suggestons");

//     return RawAutocomplete(
//       optionsBuilder: (TextEditingValue textEditingValue) async {
//         widget.onChange(textEditingValue.text);
//         print("     ==========     optionsBuilder    ==========     ");
//         // await generateSuggestions(amount: widget.amount);
//         print("========== ACTUAL SUGGESTIONS ==========: $suggestons");
//         // if (textEditingValue.text == '') {
//         //   return const Iterable<String>.empty();
//         // } else {
//         //   // List<String> matches = <String>[];
//         //   // matches.addAll(suggestons);

//         //   // matches.retainWhere((s) {
//         //   //   return s
//         //   //       .toLowerCase()
//         //   //       .contains(textEditingValue.text.toLowerCase());
//         //   // });
//         //   // return matches;
//         //   return suggestons;
//         // }

//         if (suggestons.isEmpty) {
//           return const Iterable<String>.empty();
//         } else {
//           return suggestons;
//         }
//       },
//       onSelected: (String selection) {
//         widget.onSelect(selection);
//         print("selection: $selection");
//         // widget.controller.text = selection;
//         // double? amount = double.tryParse(selection);
//         // BlocProvider.of<CategoryBloc>(context).categoryBudget = amount;
//         // print('You just selected $selection');
//       },
//       fieldViewBuilder: (BuildContext context, TextEditingController controller,
//           FocusNode focusNode, VoidCallback onFieldSubmitted) {
//         return TextFormField(
//           keyboardType: TextInputType.number,
//           inputFormatters: <TextInputFormatter>[
//             FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
//             TextInputFormatter.withFunction((oldValue, newValue) {
//               try {
//                 final text = newValue.text;
//                 if (text.isNotEmpty) double.parse(text);
//                 return newValue;
//               } catch (_) {}
//               return oldValue;
//             }),
//           ],
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(12),
//               ),
//             ),
//             hintText: "Budget",
//           ),
//           controller: controller,
//           focusNode: focusNode,
//           validator: (value) {
//             if (value!.isNotEmpty) {
//               return null;
//             } else {
//               return "Enter budget amount";
//             }
//           },
//           onChanged: (value) {
//             print(" ==========     onChange    ========== : $value");
//             // widget.onChange(value);
//           },
//           // onSubmitted: (String value) {},
//         );
//       },
//       optionsViewBuilder: (BuildContext context,
//           void Function(String) onSelected, Iterable<String> options) {
//         print("     ==========     optionsViewBuilder    ==========     ");
//         return Align(
//           alignment: Alignment.topLeft,
//           child: Material(
//             type: MaterialType.transparency,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxHeight: 300),
//               child: SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFf5ded6),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8),
//                     ),
//                   ),
//                   margin: const EdgeInsets.only(right: 24, top: 6),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Alternative Suggestions",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: context.primary),
//                         ),
//                       ),
//                       Column(
//                         children: options.mapIndexed(
//                           (index, opt) {
//                             return InkWell(
//                               onTap: () {
//                                 print(
//                                     " ==========     onTap    ========== : $opt");
//                                 onSelected(opt);
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.all(2),
//                                 child: Card(
//                                   child: Container(
//                                     width: double.infinity,
//                                     padding: const EdgeInsets.all(16),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           "GHS $opt",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: context.primary),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ).toList(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

Widget autoCompleteTextInput(
    {required BuildContext context,
    required double amount,
    required Function(String) onSelect,
    required Function(String) onChange}) {
  List<String> generateBudgetSusggestions({required String amt}) {
    List<String> suggestions = [];

    // print(
    // "=======================  suggestions: $suggestions =======================");

    if (double.tryParse(amt) != null) {
      double amount = double.parse(amt);
      suggestions.add(
        (amount * 0.8).toString(),
      );

      // Subtract 10%
      suggestions.add(
        (amount * 0.9).toString(),
      );

      // Add 10% more
      suggestions.add(
        (amount * 1.1).toString(),
      );

      // Add 20% more
      suggestions.add(
        (amount * 1.2).toString(),
      );
    }

    print(
        "=======================  suggestions: $suggestions =======================");

    return suggestions;
  }

  return RawAutocomplete(
    optionsBuilder: (TextEditingValue textEditingValue) {
      print(
          "=======================  textEditingValue.text: ${textEditingValue.text} =======================");
      onChange(textEditingValue.text);
      if (textEditingValue.text == '') {
        return const Iterable<String>.empty();
      } else {
        return generateBudgetSusggestions(amt: textEditingValue.text);
      }
    },
    onSelected: (String selection) {
      onSelect(selection);
      print("selection: $selection");
      // widget.controller.text = selection;
      // double? amount = double.tryParse(selection);
      // BlocProvider.of<CategoryBloc>(context).categoryBudget = amount;
      // print('You just selected $selection');
    },
    fieldViewBuilder: (BuildContext context, TextEditingController controller,
        FocusNode focusNode, VoidCallback onFieldSubmitted) {
      return TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          TextInputFormatter.withFunction((oldValue, newValue) {
            try {
              final text = newValue.text;
              if (text.isNotEmpty) double.parse(text);
              return newValue;
            } catch (_) {}
            return oldValue;
          }),
        ],
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          hintText: "Budget",
        ),
        controller: controller,
        focusNode: focusNode,
        validator: (value) {
          if (value!.isNotEmpty) {
            return null;
          } else {
            return "Enter budget amount";
          }
        },
        onChanged: (value) {
          print("onChange: $value");
          // onChange(value);
        },
        // onSubmitted: (String value) {},
      );
    },
    optionsViewBuilder: (BuildContext context, void Function(String) onSelected,
        Iterable<String> options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          type: MaterialType.transparency,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFf5ded6),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                margin: const EdgeInsets.only(right: 24, top: 6),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Budget Suggestions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.primary),
                      ),
                    ),
                    Column(
                      children: options.mapIndexed((index, opt) {
                        String amt = "0";
                        if (double.tryParse(opt) != null) {
                          amt = double.parse(opt).toStringAsFixed(2);
                        }
                        return InkWell(
                          onTap: () {
                            print("onTap: $amt");
                            onSelected(amt);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "GHS $amt",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: context.primary),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
