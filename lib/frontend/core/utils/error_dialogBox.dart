import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorDialogbox {
   void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign In Failed'),
        content: const Text('Wrong Credentials, please try again.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('OK'),
          ),
        ],
      )
    );
}
}