import 'package:flutter/material.dart';

InputDecoration input_style_icon(String hint, IconData icon) {
  return InputDecoration(
    labelText: hint,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}

InputDecoration input_style(String hint) {
  return InputDecoration(
    labelText: hint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );
}
