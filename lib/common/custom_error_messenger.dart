import 'package:flutter/material.dart';

ScaffoldMessengerState errorMessenger(BuildContext context) {
  return ScaffoldMessenger.of(context);
}

void customErrorMessenger({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
    ),
  );
}
