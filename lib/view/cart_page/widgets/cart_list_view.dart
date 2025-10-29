import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'dart:io';

class CartListView extends StatelessWidget {
  const CartListView({
    super.key,
    required this.cartItems,
    required this.selectedItems,
    required this.onRemoveItem,
    required this.onUpdateCount,
    required this.onItemCheck,
  });

  final List<CartItem> cartItems;
  final Set<int> selectedItems;
  final Function(int) onRemoveItem;
  final Function(int, int) onUpdateCount;
  final Function(int, bool) onItemCheck;

  // [선택한 상품의 총 가격 계산]
  int selectedItemsPrice() {
    int total = 0;
    for (final index in selectedItems) {
      final item = cartItems[index];
      total += item.book.price * item.count;
    }
    return total;
  }

  // [선택한 상품들 구매하기]
  void buyItems(BuildContext context) {
    // 선택된 상품이 없는 경우
    if (selectedItems.isEmpty) {
      noItemsSelectedToast(context);
      return;
    }
    showBuyDialog(context);
  }

  // [구매할 상품을 선택해주세요 토스트]
  void noItemsSelectedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('구매할 상품을 선택해주세요.'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // [구매하기 팝업]
  void showBuyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('구매하기')),
          content: Text('상품을 구매하시겠습니까?', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showCompleteDialog(context);
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // [구매 완료 팝업]
  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('구매 완료')),
          content: Text('구매가 완료되었습니다.', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('확인'),
            ),
          ],
        );
      },
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
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      // 체크 버튼
                      CheckButton(
                        isChecked: selectedItems.contains(index),
                        onTap: (bool? value) =>
                            onItemCheck(index, value ?? false),
                      ),

                      // 상품 이미지
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                        width: 90,
                        height: 120,
                        child:
                            cartItem.book.images == null ||
                                cartItem.book.images!.isEmpty
                            ? Center(
                                child: Text(
                                  "No\nImage",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(cartItem.book.images!.first),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      SizedBox(width: 12),

                      // 상품 정보
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            // 책 이름
                            Text(
                              "도서명 : ${cartItem.book.title}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            // 책 저자
                            Text("저자 : ${cartItem.book.author}"),
                            SizedBox(height: 12),
                            // 책 가격
                            Text(
                              '가격 : ${cartItem.book.price.toStringAsFixed(0)}원',
                            ),
                            // 책 수량 버튼
                            CountButton(
                              index: index,
                              onUpdateCount: onUpdateCount,
                              cartItem: cartItem,
                            ),
                          ],
                        ),
                      ),
                      // 삭제 버튼
                      DeleteCartButton(index: index, onRemove: onRemoveItem),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // 하단 결제 바
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
              // 결제 금액
              Text(
                '결제 금액 : ${NumberFormat('#,###').format(selectedItemsPrice())}원',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),

              // 결제 버튼
              TextButton(
                onPressed: () {
                  buyItems(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: selectedItems.isNotEmpty
                      ? Colors.grey[600]
                      : Colors.grey[400],
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "${selectedItems.length}개 구매하기",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeleteCartButton extends StatelessWidget {
  /// [장바구니에서 제외 버튼 위젯]
  const DeleteCartButton({
    super.key,
    required this.index,
    required this.onRemove,
  });

  final int index;
  final Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // 경고 대화상자 출력
            return AlertDialog(
              title: Center(child: Text('진짜 안 사?')),
              content: Text('진짜 진짜 진짜 진짜 진짜 진짜 진짜 진짜 안 사?'),
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

class CountButton extends StatelessWidget {
  /// [상품 수량 버튼 위젯]
  const CountButton({
    super.key,
    required this.index,
    required this.onUpdateCount,
    required this.cartItem,
  });

  final int index;
  final Function(int index, int newCount) onUpdateCount;
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onUpdateCount(index, cartItem.count - 1);
          },
          icon: Icon(Icons.remove),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[500]!),
          ),
          child: Text('${cartItem.count}'),
        ),
        IconButton(
          onPressed: () {
            onUpdateCount(index, cartItem.count + 1);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}

class CheckButton extends StatelessWidget {
  /// [구매할 상품 체크 토글 위젯]
  const CheckButton({super.key, required this.isChecked, required this.onTap});

  final bool isChecked;
  final Function(bool?) onTap;

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: isChecked, onChanged: onTap);
  }
}
