import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/home_page/widgets/book_list_view.dart';

class BookListSection extends StatelessWidget {
  final List<BookEntity> bookList;
  final Function(int) onNavigateToDetail;

  const BookListSection({
    super.key,
    required this.bookList,
    required this.onNavigateToDetail,
  });

  @override
  Widget build(BuildContext context) {
    return BookListView(
      key: UniqueKey(),
      bookList: bookList,
      onNavigateToDetail: onNavigateToDetail,
    );
  }
}
