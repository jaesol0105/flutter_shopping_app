import 'package:flutter/material.dart';
import 'package:flutter_project_3/view/cart_page/cart_page.dart';

class CartListView extends StatelessWidget {
  final List<CartEntity> cartItems;
  final Function(int) onRemove;
  final Function(int, int) onUpdateHowMany;

  const CartListView({
    super.key,
    required this.cartItems,
    required this.onRemove,
    required this.onUpdateHowMany,
  });

  int totalPrice() {
    return cartItems.fold(
      0,
      (total, item) => total + (item.price * item.howMany),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            padding: EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return Card(
                margin: EdgeInsets.only(bottom: 16),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // 책 이미지
                      Icon(Icons.book, size: 85),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 책 이름
                            Text(cartItem.name, maxLines: 1),
                            SizedBox(height: 8),
                            // 책 가격
                            Text('${cartItem.price.toStringAsFixed(0)}원'),
                            SizedBox(height: 12),
                            // 책 수량 버튼
                            HowManyButton(
                              index: index,
                              onUpdateHowMany: onUpdateHowMany,
                              cartItem: cartItem,
                            ),
                          ],
                        ),
                      ),
                      // 삭제 버튼
                      DeleteCartButton(index: index, onRemove: onRemove),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(top: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // 총 금액
                children: [
                  Text('총 금액:'),
                  Text('  ${totalPrice().toStringAsFixed(0)}원'),
                ],
              ),
              // 결제 버튼
              TextButton(
                onPressed: () {
                  // 기능 미구현
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  foregroundColor: Colors.white,
                ),
                child: Text('결제하기'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteCartButton extends StatelessWidget {
  const DeleteCartButton({
    super.key,
    required this.index,
    required this.onRemove,
  });

  final int index;
  final Function(int p1) onRemove;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Center(child: Text('진짜 안 사?')),
              content: Text('진짜 진짜 진짜 안 사?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onRemove(index);
                  },
                  child: Text('삭제', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      icon: Icon(Icons.close, color: Colors.red),
    );
  }
}

class HowManyButton extends StatelessWidget {
  const HowManyButton({
    super.key,
    required this.index,
    required this.onUpdateHowMany,
    required this.cartItem,
  });

  final int index;
  final Function(int p1, int p2) onUpdateHowMany;
  final CartEntity cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onUpdateHowMany(index, cartItem.howMany - 1);
          },
          icon: Icon(Icons.remove),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text('${cartItem.howMany}'),
        ),
        IconButton(
          onPressed: () {
            onUpdateHowMany(index, cartItem.howMany + 1);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
