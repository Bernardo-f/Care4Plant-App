import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

Widget input(String hintText, Function(String) changed,
    {bool obscureText = false, String? errorText}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextFormField(
      onChanged: changed,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        errorMaxLines: 3,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        contentPadding: const EdgeInsets.only(left: 10),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

Widget textAfterInputs(String text) {
  return Center(
    child: Text(
      text,
      style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
    ),
  );
}
