import 'package:flutter/material.dart';
import 'package:sika_purse/src/core/common.dart';

class SikaPurseCard extends StatelessWidget {
  const SikaPurseCard({
    super.key,
    required this.child,
    this.elevation,
    this.color,
    this.shape,
  });

  final Widget child;
  final Color? color;
  final double? elevation;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: color ?? context.surfaceVariant,
      clipBehavior: Clip.antiAlias,
      elevation: elevation ?? 2.0,
      shadowColor: color ?? context.shadow,
      child: child,
    );
  }
}

class SikaPurseOutlineCard extends StatelessWidget {
  const SikaPurseOutlineCard({
    super.key,
    required this.child,
    this.shape,
  });

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              width: 1,
              color: context.outline,
            ),
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: context.surface,
      shadowColor: context.shadow,
      child: child,
    );
  }
}

class SikaPurseFilledCard extends StatelessWidget {
  const SikaPurseFilledCard({
    super.key,
    required this.child,
    this.shape,
    this.color,
  });

  final Widget child;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: color ?? context.surfaceVariant,
      shadowColor: context.shadow,
      child: child,
    );
  }
}
