import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/home_page/widgets/book_view.dart';

class BookListView extends StatelessWidget {
  /// [상품 목록 출력 위젯]
  const BookListView({
    super.key,
    required this.bookList,
    required this.onNavigateToDetail,
  });

  final List<BookEntity> bookList;
  final void Function(int) onNavigateToDetail;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 16),
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        BookEntity item = bookList[index];
        return BookView(
          key: UniqueKey(),
          book: item,
          onNavigateToDetail: () => onNavigateToDetail(index),
        );
      },
    );
  }
}
