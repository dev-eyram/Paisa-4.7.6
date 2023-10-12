import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sika_purse/src/core/common.dart';

class SikaPurseBaseWidget extends StatelessWidget {
  const SikaPurseBaseWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: context.surface,
        systemNavigationBarContrastEnforced: true,
      ),
      child: child,
    );
  }
}
