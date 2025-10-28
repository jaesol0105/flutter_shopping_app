import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:intl/intl.dart';

class BookDetailBottomView extends StatefulWidget {
  /// [상품 구매 하단바 위젯]
  const BookDetailBottomView({
    super.key,
    required this.book,
    required this.addBookToCartList,
    required this.navigateToCart,
  });
  final BookEntity book;
  final void Function(BookEntity, int) addBookToCartList;
  final VoidCallback navigateToCart;

  @override
  State<BookDetailBottomView> createState() => _BookDetailBottomViewState();
}

class _BookDetailBottomViewState extends State<BookDetailBottomView> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white10,
      child: Expanded(
        child: Row(
          children: [
            // 개수 카운터
            DetailCounter(
              price: widget.book.price,
              count: count,
              onChanged: (changedCount) {
                setState(() {
                  count = changedCount;
                });
              },
            ),
            Spacer(),
            // 구매 버튼
            GestureDetector(
              onTap: () => purchaseBook(context),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "구매",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(width: 12),

            // 장바구니 버튼
            GestureDetector(
              onTap: () {
                widget.addBookToCartList(widget.book, count);
                widget.navigateToCart();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.shopping_cart, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [상품 구매 대화상자 출력 및 완료 처리]
  void purchaseBook(BuildContext context) {
    _showPurchaseConfirmDialog(context);
  }

  /// [구매 확인 다이얼로그]
  void _showPurchaseConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('구매 확인')),
          content: Text("${widget.book.title}을 $count개 구매하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showPurchaseCompleteDialog(context);
              },
              child: Text("확인", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  /// [구매 완료 다이얼로그]
  void _showPurchaseCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('구매 완료')),
          content: Text("구매가 완료되었습니다!"),
          actions: [
            TextButton(
              onPressed: () {
                // 홈 화면으로 이동
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }
}

class DetailCounter extends StatelessWidget {
  /// [상품 개수 카운터 위젯]
  const DetailCounter({
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
          width: 130,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
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
