import 'package:flutter/material.dart';

class ErrorDialogbox {
   void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign In Failed'),
        content: Text('Wrong Credentials, please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      )
    );
}
}