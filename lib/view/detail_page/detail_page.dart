import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_3/view/cart_page/cart_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(
    this.title,
    this.author,
    this.description,
    this.image,
    this.price,
  );
  final String title;
  final String author;
  final String? description;
  final String? image;
  final int price;
  final int count = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //상세페이지
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "상세페이지",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 4,
        shadowColor: Colors.grey.withValues(alpha: 1),
      ),

      body: ListView(
        children: [
          //맨위 이미지
          SizedBox(
            height: 350,
            child: image == null || image == ""
                ? Container(color: Colors.grey)
                : Image.file(File(image ?? ""), fit: BoxFit.cover),
          ),

          SizedBox(height: 25),

          //책 제목
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "도서명 : $title",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          //책 저자
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),

            child: Text(
              "저자: $author",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          //책 저자 밑 선
          detailPageDivider(),

          //책의 가격
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "책의 가격 :$price 원",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          // 책 가격 밑 선
          detailPageDivider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "책 소개: $description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 30),
        ],
      ), //하단 버튼 종류
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DetailCounter(),
            //구매 버튼
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [Text("$title을 $count개 구매하시겠습니까?")],
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
                                    child: ListBody(children: [Text("구매완료!")]),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.popUntil(context, (route) => route.isFirst);
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (contet) => const DetailPage(
                //       "assets/book_1.jpg",
                //       "나는 토마토 절대 안먹어",
                //       "로렌차일드",
                //       "나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,",
                //       99999,
                //     ),
                //   ),
                // );
              },

              //구매 컨테이너
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

            //장바구니 버튼
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              // 장바구니 컨테이너
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
      ),
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

class DetailCounter extends StatefulWidget {
  // const DetailCounter(Key? key):super (key: key);
  @override
  DetailCounterState createState() => DetailCounterState();
}

class DetailCounterState extends State<DetailCounter> {
  int counter = 1;
  int total = 9999;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //- 함수
        IconButton(
          onPressed: () => {
            setState(() {
              if (counter > 1) {
                counter--;
                total = 9999 * counter;
              }
            }),
          },
          icon: const Icon(Icons.remove),
        ),
        // buildButton(Icons.remove),
        //카운팅
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 36,
          child: Text(
            "$counter",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        //+ 함수
        IconButton(
          onPressed: () => {
            setState(() {
              counter++;
              total = 9999 * counter;
            }),
          },
          icon: const Icon(Icons.add),
        ),
        //총가격
        SizedBox(
          width: 90,
          height: 46,
          child: Text("총 가격: $total 원", style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
