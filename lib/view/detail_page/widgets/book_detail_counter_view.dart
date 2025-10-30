import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookDetailCounter extends StatelessWidget {
  /// [상품 개수 카운터 위젯]
  const BookDetailCounter({
    super.key,
    required this.price,
    required this.count,
    required this.onChanged,
  });

  final int price;
  final int count;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    int total = price * count;
    return Row(
      children: [
        IconButton(
          onPressed: () => {
            if (count > 1) {onChanged(count - 1)},
          },
          icon: const Icon(Icons.remove),
        ),

        // 현재 수량
        Container(
          width: 40,
          height: 30,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Center(child: Text("$count", style: TextStyle(fontSize: 15))),
        ),

        // 수량 더하기 (+)
        IconButton(
          onPressed: () => {onChanged(count + 1)},
          icon: const Icon(Icons.add),
        ),

        // 총 가격
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "${NumberFormat('#,###').format(total)} 원",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
