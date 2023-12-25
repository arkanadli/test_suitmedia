// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.conn,
    required this.hintText,
  });

  final TextEditingController conn;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: conn,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black.withAlpha(70),
        ),
      ),
    );
  }
}
