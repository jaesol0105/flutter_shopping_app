import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';

class BookView extends StatelessWidget {
  /// [상품(도서) 아이템 위젯]
  const BookView({
    super.key,
    required this.book,
    required this.onNavigateToDetail,
  });

  final BookEntity book;
  final VoidCallback onNavigateToDetail;

  @override
  Widget build(BuildContext context) {
    final images = book.images ?? [];

    return Card(
      elevation: 2,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onNavigateToDetail,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: images.isEmpty
                    ? Center(
                        child: Text(
                          'No\nImage',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : Image.file(File(images.first), fit: BoxFit.cover),
              ),
              SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "도서명 : ${book.title}",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text("저자 : ${book.author}", style: TextStyle(fontSize: 14)),
                  Text(
                    "소개 : ${book.description}",
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "가격 : ${NumberFormat('#,###').format(book.price)} 원",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
