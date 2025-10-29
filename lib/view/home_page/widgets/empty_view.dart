import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  /// [빈 리스트 뷰 위젯]
  const EmptyView({super.key, required this.text});

  final String text;

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
