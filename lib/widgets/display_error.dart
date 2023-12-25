// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class DisplayError extends StatelessWidget {
  const DisplayError({
    super.key,
    this.function,
    required this.error,
  });
  final void function;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              function;
            },
            icon: const Icon(
              Icons.refresh,
              size: 40,
            ),
          ),
          Text(
            error,
          ),
          const Text(
            "Tap to Refresh",
          )
        ],
      ),
    );
  }
}
