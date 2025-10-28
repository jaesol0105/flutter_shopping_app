import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/util/util.dart';

class BookDetailView extends StatelessWidget {
  /// [상품 디테일 내용 위젯]
  const BookDetailView({super.key, required this.book});

  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 맨위 이미지
        SizedBox(
          height: 350,
          child: book.image == null || book.image == ""
              ? Container(color: Colors.grey)
              : Image.file(File(book.image ?? ""), fit: BoxFit.cover),
        ),
        SizedBox(height: 25),

        // 책 제목
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "도서명 : ${book.title}",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),

        // 책 저자
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "저자 : ${book.author}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        detailPageDivider(),

        // 책의 가격
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "책의 가격 : ${fmtPrice(book.price)} 원",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        detailPageDivider(),

        // 책 소개
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: book.description == null
              ? Text("")
              : Text(
                  "책 소개 : ${book.description}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
        ),

        SizedBox(height: 30),
      ],
    );
  }

  // 디테일 페이지 의 선(줄)
  SizedBox detailPageDivider() {
    return SizedBox(
      width: double.infinity,
      child: Divider(
        // ← AppBar 밑에 선
        thickness: 1, // 선 두께
        color: Colors.grey, // 선 색상
      ),
    );
  }
}
