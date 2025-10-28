import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

          // 구매 버튼
          GestureDetector(
            onTap: () => purchaseBook(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              width: 60,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "구매",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // 장바구니 버튼
          GestureDetector(
            onTap: () {
              widget.addBookToCartList(widget.book, count);
              widget.navigateToCart();
            },
            child: Container(
              width: 52,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.shopping_cart, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// [상품 구매 대화상자 출력 및 완료 처리]
  void purchaseBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [Text("${widget.book.title}을 $count개 구매하시겠습니까?")],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(children: [Text("구매 완료!")]),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // 홈 화면으로 이동
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                          child: Text("확인"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("확인"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("취소"),
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
        // 수량 빼기 (-)
        IconButton(
          onPressed: () => {
            if (count > 1) {onChanged(count - 1)},
          },
          icon: const Icon(Icons.remove),
        ),

        // 현재 수량
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 36,
          child: Text(
            "$count",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),

        // 수량 더하기 (+)
        IconButton(
          onPressed: () => {onChanged(count + 1)},
          icon: const Icon(Icons.add),
        ),

        // 총 가격
        SizedBox(
          width: 90,
          height: 46,
          child: Text("총 가격: $total 원", style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
