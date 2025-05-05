import 'package:flutter/material.dart';

class AppErrorView extends StatelessWidget {
  final String message;

  const AppErrorView({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Error: $message',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
