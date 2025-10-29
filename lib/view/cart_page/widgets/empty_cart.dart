import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '장바구니가 비어있습니다',
        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
      ),
    );
  }
}
