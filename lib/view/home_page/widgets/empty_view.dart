import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '상품이 없습니다.',
        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
      ),
    );
  }
}
