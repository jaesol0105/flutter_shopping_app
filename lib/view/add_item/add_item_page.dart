// 판매(item) 등록 화면

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;

class BookEntity {
  String title = "";
  String description = "";
  int price = 0;
  String author = "";
  List<String> images = [];
  int count = 0;
}

class AddItem extends StatefulWidget {
  AddItem({super.key});
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  final authorController = TextEditingController();
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  void vaildcheck(String title, String author, String des, String price) {
    try {
      if (title.isEmpty) {
        showToast(context, '도서명을 입력해 주세요');
        return;
      }
      if (author.isEmpty) {
        showToast(context, '저자명을 입력해 주세요');
        return;
      }
      if (des.isEmpty) {
        showToast(context, '설명을 입력해 주세요');
        return;
      }
      if (price.isEmpty) {
        showToast(context, '가격을 입력해 주세요');
        return;
      }
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //## 빈 화면을 터치하면 키보드 제거
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context); //## 이전 페이지로 이동
            },
          ),
          title: Text("판매 등록"),
        ),
        body: Scrollbar(
          thumbVisibility: false,
          trackVisibility: false,
          interactive: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: displayView(
                widget.titleController,
                widget.authorController,
                widget.desController,
                widget.priceController,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 40,
          ),
          child: ElevatedButton(
            onPressed: () {
              // 저장 로직
              String title = widget.titleController.text.toString();
              String des = widget.desController.text.toString();
              String author = widget.authorController.text.toString();
              String price = widget.priceController.text.toString();
              //##List<String> images = 별도 정의 필요

              //유효성 체크 함수
              vaildcheck(title, author, des, price);
              BookEntity data = BookEntity();
              data.title = title;
              data.description = des;
              data.author = author;
              data.price = int.parse(price.replaceAll(',', ''));
              Navigator.pop(context, data);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 54),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              '저장',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget displayView(
  TextEditingController titleController,
  TextEditingController authorController,
  TextEditingController desController,
  TextEditingController priceController,
) {
  return Column(
    children: [
      titleLabel("사진 등록(*/10)"),
      SizedBox(height: 5),
      GestureDetector(
        onTap: () {
          // 갤러리 열기
        },
        child: Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.black45,
                size: 24,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 30),
      titleLabel("도서명"),
      SizedBox(height: 5),
      TextField(
        controller: titleController,
        maxLength: 30,
        maxLines: 1,
        decoration: styleInputDecoration().copyWith(hintText: '도서명을 입력하세요.'),
      ),
      SizedBox(height: 30),
      titleLabel("저자명"),
      SizedBox(height: 5),
      TextField(
        controller: authorController,
        maxLength: 30,
        maxLines: 1,
        decoration: styleInputDecoration().copyWith(hintText: '저자명을 입력하세요.'),
      ),
      SizedBox(height: 30),
      titleLabel("설명"),
      SizedBox(height: 5),
      TextField(
        controller: desController,
        maxLength: 1000,
        maxLines: 8,
        decoration: styleInputDecoration().copyWith(
          hintText: '구매 시기, 사용감(찍김, 낙서)등 책의 상태를 자세히 적어주세요.',
        ),
      ),
      SizedBox(height: 30),
      titleLabel("가격"),
      SizedBox(height: 5),
      Stack(
        children: [
          TextField(
            controller: priceController,
            maxLength: 10,
            inputFormatters: <TextInputFormatter>[
              CurrencyTextInputFormatter.currency(decimalDigits: 0, symbol: ""),
            ],
            keyboardType: TextInputType.number,
            decoration: styleInputDecoration().copyWith(hintText: '0'),
          ),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: Row(
              children: [
                Spacer(),
                Text(
                  "원",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 20)),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 30),
    ],
  );
}

// ## TextField 스타일 정의
InputDecoration styleInputDecoration() {
  return InputDecoration(
    counterText: '',
    // contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
    // ## 포커스가 없을 때 (기본) 테두리 색상
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 3),
      borderRadius: BorderRadius.circular(10.0),
    ),
    // ## 포커스가 있을 때 (선택되었을 때) 테두리 색상
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black, // 원하는 포커스 색상
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

// ## 인풋창 라벨 스타일 정의
Widget titleLabel(String title) {
  return Align(alignment: Alignment.centerLeft, child: Text(title));
}

// ## 유효성 체크 토스트 팝업
void showToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black54, // 배경색
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating, // 필수! margin 적용하려면 필요
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    ),
  );
}
