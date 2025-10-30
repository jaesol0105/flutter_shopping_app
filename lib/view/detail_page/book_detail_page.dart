import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/detail_page/widgets/book_detail_bottom_view.dart';
import 'package:flutter_project_3/view/detail_page/widgets/book_detail_view.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({
    super.key,
    required this.book,
    required this.index,
    required this.onAddBookToCartList,
    required this.onNavigateToCart,
  });

  final BookEntity book;
  final int index;
  final void Function(BookEntity, int) onAddBookToCartList;
  final VoidCallback onNavigateToCart;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상세 페이지")),

      // 상품의 상세 내용 뷰
      body: BookDetailView(book: widget.book),

      // 하단 버튼
      bottomNavigationBar: BookDetailBottomView(
        book: widget.book,
        onAddBookToCartList: widget.onAddBookToCartList,
        onNavigateToCart: widget.onNavigateToCart,
      ),
    );
  }
}
