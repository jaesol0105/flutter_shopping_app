import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/util/util.dart';

class BookDetailView extends StatefulWidget {
  /// [상품 디테일 내용 위젯]
  const BookDetailView({super.key, required this.book});
  final BookEntity book;

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  int currentIndex = 0; // 현재 보고 있는 이미지 인덱스

  @override
  Widget build(BuildContext context) {
    final images = widget.book.images ?? [];

    return ListView(
      children: [
        // 이미지 슬라이더
        SizedBox(
          height: 350,
          child: images.isEmpty
              ? Container(color: Colors.grey)
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() => currentIndex = index);
                      },
                      itemBuilder: (context, index) {
                        return Image.file(
                          File(images[index]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),

                    // 좌측 화살표
                    if (images.length > 1)
                      Positioned(
                        left: 8,
                        child: Icon(
                          Icons.chevron_left,
                          size: 40,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),

                    //우측 화살표
                    if (images.length > 1)
                      Positioned(
                        right: 8,
                        child: Icon(
                          Icons.chevron_right,
                          size: 40,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),

                    // 인디케이터
                    if (images.length > 1)
                      Positioned(
                        bottom: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.4),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
        SizedBox(height: 25),

        // 책 제목
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "${widget.book.title}",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),

        // 책 저자
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "저자 : ${widget.book.author}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        detailPageDivider(),

        // 책의 가격
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "가격 : ${fmtPrice(widget.book.price)} 원",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        detailPageDivider(),

        // 책 소개
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: widget.book.description == null
              ? Text("")
              : Text(
                  "소개 : ${widget.book.description}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  // 디테일 페이지 의 선(줄)
  Container detailPageDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: 100,
      child: Divider(
        // ← AppBar 밑에 선
        thickness: 1, // 선 두께
        color: Colors.grey, // 선 색상
      ),
    );
  }
}
