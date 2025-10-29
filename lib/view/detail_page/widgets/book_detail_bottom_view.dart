import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/detail_page/widgets/book_detail_counter_view.dart';

class BookDetailBottomView extends StatefulWidget {
  /// [상품 구매 하단바 위젯 (구매/장바구니담기)]
  const BookDetailBottomView({
    super.key,
    required this.book,
    required this.onAddBookToCartList,
    required this.onNavigateToCart,
  });

  final BookEntity book;
  final void Function(BookEntity, int) onAddBookToCartList;
  final VoidCallback onNavigateToCart;

  @override
  State<BookDetailBottomView> createState() => _BookDetailBottomViewState();
}

class _BookDetailBottomViewState extends State<BookDetailBottomView> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white10,
      child: Row(
        children: [
          // 개수 카운터
          BookDetailCounter(
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
            child: Expanded(
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
          ),

          SizedBox(width: 6),

          // 장바구니 버튼
          GestureDetector(
            onTap: () {
              widget.onAddBookToCartList(widget.book, count);
              widget.onNavigateToCart();
            },
            child: Expanded(
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
          ),
        ],
      ),
    );
  }

  /// [상품 구매 다이얼로그 출력 및 완료 처리]
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
