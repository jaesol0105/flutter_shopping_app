import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String text;

  const EmptyView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
      ),
    );
  }
}
