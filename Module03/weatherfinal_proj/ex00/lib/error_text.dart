import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;

  const ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ));
  }
}
