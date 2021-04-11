import 'package:flutter/material.dart';

Color red = Color(0xFFEA2B1F);
Color yellow = Color(0xFFFFD23F);
Color green = Color(0xFF53A548);
Color blue = Color(0xFF1B2CC1);
Color white = Color(0xFFFFFFDB);
Color black = Colors.black87;

class ColorUtil {
  static List<Color> colors = [red, yellow, green, blue];
  static Color getColor(index) {
    return colors[index % colors.length];
  }
}
