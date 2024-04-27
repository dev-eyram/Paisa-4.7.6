import 'package:flutter/material.dart';
import 'package:sika_purse/src/presentation/widgets/sika_purse_big_button_widget.dart';

Future<void> showPreviousBudgetDialog({required BuildContext context}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        // color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Container()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SikaPurseBigButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    title: "Cancel",
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Future<void> showPreviousBudgetDialog({required BuildContext context}) {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Basic dialog title'),
//         content: const Text(
//           'A dialog is a type of modal window that\n'
//           'appears in front of app content to\n'
//           'provide critical information, or prompt\n'
//           'for a decision to be made.',
//         ),
//         actions: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Disable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Enable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }