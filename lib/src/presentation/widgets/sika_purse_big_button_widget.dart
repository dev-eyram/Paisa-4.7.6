import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sika_purse/src/core/common.dart';

class SikaPurseBigButton extends StatelessWidget {
  const SikaPurseBigButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        foregroundColor: context.onPrimary,
        backgroundColor: context.primary,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: context.titleLarge?.fontSize,
        ),
      ),
    );
  }
}

class SikaPurseButton extends StatelessWidget {
  const SikaPurseButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.onPrimary,
        backgroundColor: context.primary,
      ),
      child: Text(title),
    );
  }
}

class SikaPurseIconButton extends StatelessWidget {
  const SikaPurseIconButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.iconData,
  });

  final IconData iconData;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.onPrimary,
        backgroundColor: context.primary,
      ),
      label: Text(title),
      icon: Icon(iconData),
    );
  }
}

class SikaPurseTextButton extends StatelessWidget {
  const SikaPurseTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.primary,
      ),
      child: Text(title),
    );
  }
}

class SikaPurseOutlineButton extends StatelessWidget {
  const SikaPurseOutlineButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.primary,
      ),
      child: Text(title),
    );
  }
}

class SikaPurseOutlineIconButton extends StatelessWidget {
  const SikaPurseOutlineIconButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: context.primary,
      ),
      label: Text(title),
      icon: const Icon(MdiIcons.sortVariant),
    );
  }
}
