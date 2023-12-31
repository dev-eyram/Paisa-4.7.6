import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/bloc/home_bloc.dart';

class SikaPurseTitleWidget extends StatelessWidget {
  const SikaPurseTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is CurrentIndexState) {
          return Text(
            BlocProvider.of<HomeBloc>(context).getPageFromIndex(state.currentPage).name(context),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
