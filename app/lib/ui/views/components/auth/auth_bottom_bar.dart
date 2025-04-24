import 'package:flutter/material.dart';

BottomAppBar bottomBar(String text, String textRedirect, BuildContext context, String nextPage) {
  return BottomAppBar(
    color: Colors.transparent,
    elevation: 0.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextButton(
          onPressed: () => Navigator.popAndPushNamed(context, nextPage),
          child: Text(
            textRedirect,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
