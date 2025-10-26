import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(
    this.picture,
    this.title,
    this.name,
    this.money,
    this.description,
  );
  final String picture;
  final String title;
  final String name;
  final int money;
  final String description;

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
          Image.asset(picture, width: double.infinity, fit: BoxFit.contain),
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
              "저자: $name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          //책 저자 밑 선
          detailPageDivider(),

          //책의 가격
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "책의 가격 :$money 원",
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
            //바로구매 버튼
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contet) => const DetailPage(
                      "assets/book_1.jpg",
                      "나는 토마토 절대 안먹어",
                      "로렌차일드",
                      99999,
                      "나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,",
                    ),
                  ),
                );
              },
              //바로구매 컨테이너
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: 260,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "바로구매",
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
                  MaterialPageRoute(
                    builder: (context) => const DetailPage(
                      "assets/book_2.jpg",
                      "나는 토마토 절대 안먹어",
                      "로렌차일드",
                      99999,
                      "나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,나는토마토 절대 안먹어,",
                    ),
                  ),
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
