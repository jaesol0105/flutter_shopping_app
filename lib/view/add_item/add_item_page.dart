// 판매(item) 등록 화면
import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/add_item/widgets/add_item_view.dart';
import 'package:image_picker/image_picker.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  final authorController = TextEditingController();

  int pictureCount = 0;
  final List<XFile> images = [];

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

  void addImageToLocal(Iterable<XFile> addList) {
    setState(() {
      images.addAll(addList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ## 빈 화면을 터치하면 키보드 제거
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context); // ## 이전 페이지로 이동
            },
          ),
          title: Text("판매 등록"),
        ),

        // 상품 정보 입력
        body: Scrollbar(
          thumbVisibility: false,
          trackVisibility: false,
          interactive: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: AddItemView(
                titleController: titleController,
                authorController: authorController,
                desController: desController,
                priceController: priceController,
                addImageToLocal: addImageToLocal,
              ),
            ),
          ),
        ),

        // 저장 버튼
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
              String title = titleController.text;
              String des = desController.text;
              String author = authorController.text;
              String price = priceController.text;

              // 유효성 체크 함수
              vaildcheck(title, author, des, price);

              BookEntity data = BookEntity(
                title: titleController.text,
                author: authorController.text,
                price: int.parse(priceController.text.replaceAll(',', '')),
                description: desController.text,
              );
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
