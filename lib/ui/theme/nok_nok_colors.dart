import 'dart:ui' show Color;

import 'package:flutter/cupertino.dart';

/// A palette of [Color] constants that describe colors commonly used when
/// matching the iOS platform aesthetics.
class NokNokColors {
  NokNokColors._();

  static const Color backgroundColor = Color(0xFFEFEFEF);
  
  static const Color searchBarBackground = Color.fromARGB(255, 244, 242, 237);
  static const Color searchBarBorder = Color.fromARGB(255, 238, 231, 221);

  static const Color separator = Color(0xFFD0CFCF);

  static const Color mainThemeColor = Color(0xFF774C10);
  static const Color buttonColor = Color(0xFF816339);
  static const Color caption = Color(0xFF666666);

  static const Color productTitle = Color(0xFF007AFF);
  static const Color productDescription = Color(0x7F007AFF);
  static const Color contactInfo = Color(0xFF2C2C2C);

  static const Color addToBasket = Color(0xFF79C650);
}