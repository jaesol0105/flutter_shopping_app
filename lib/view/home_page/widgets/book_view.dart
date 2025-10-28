import 'dart:io';

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

    return Ink(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onNavigateToDetail,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: images.isEmpty
                      ? const Center(
                          child: Text('image', style: TextStyle(fontSize: 16)),
                        )
                      : Image.file(File(images.first), fit: BoxFit.cover),
                ),
                SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title, style: TextStyle(fontSize: 28)),
                    Text(
                      book.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
