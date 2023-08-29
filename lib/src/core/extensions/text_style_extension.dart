import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextStyleHelper on BuildContext {
  TextStyle get bodyMedium {
    return GoogleFonts.outfit(textStyle: Theme.of(this).textTheme.bodyMedium);
  }
}
