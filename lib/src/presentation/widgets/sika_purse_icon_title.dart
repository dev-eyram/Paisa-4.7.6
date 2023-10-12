import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/common.dart';
import '../home/bloc/home_bloc.dart';

class SikaPurseIconTitle extends StatelessWidget {
  const SikaPurseIconTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            Icons.wallet,
            color: context.primary,
            size: 32,
          ),
        ),
        Text(
          context.loc.appTitle,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            textStyle: context.titleLarge,
            color: context.onBackground,
          ),
        )
      ],
    );
  }
}

class SikaPurseTitle extends StatelessWidget {
  const SikaPurseTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String title = PageType.home.name(context);
        if (state is CurrentIndexState) {
          title = BlocProvider.of<HomeBloc>(context).getPageFromIndex(state.currentPage).name(context);
        }
        return Text(
          title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            textStyle: context.titleLarge,
            color: context.onBackground,
          ),
        );
      },
    );
  }
}

class SikaPurseIcon extends StatelessWidget {
  const SikaPurseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.wallet,
      color: context.primary,
      size: 32,
    );
  }
}
