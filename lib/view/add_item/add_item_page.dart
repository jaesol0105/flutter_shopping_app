// 판매(item) 등록 화면
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/add_item/widgets/add_item_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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

  static const int maxCount = 10;
  final List<XFile> images = [];

  /// [로컬 변수 (images)에 이미지 파일 추가]
  void addImageToLocal(Iterable<XFile> addList) {
    final remain = maxCount - images.length;
    if (remain <= 0) return;
    setState(() => images.addAll(addList.take(remain)));
  }

  /// [로컬 변수 (images)에서 이미지 파일 삭제]
  void removeImageAt(int index) {
    setState(() => images.removeAt(index));
  }

  /// [입력 유효성 검사]
  bool vaildcheck(String title, String author, String des, String price) {
    if (title.isEmpty) {
      showToast(context, '도서명을 입력해 주세요');
      return false;
    }
    if (author.isEmpty) {
      showToast(context, '저자명을 입력해 주세요');
      return false;
    }
    if (des.isEmpty) {
      showToast(context, '설명을 입력해 주세요');
      return false;
    }
    if (price.isEmpty) {
      showToast(context, '가격을 입력해 주세요');
      return false;
    }

    return true;
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
                images: images,
                addImageToLocal: addImageToLocal,
                removeImageAt: removeImageAt,
                maxCount: maxCount,
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
            bottom: 30,
          ),
          child: ElevatedButton(
            onPressed: () async {
              print('✅ 저장 버튼 눌림'); // 이게 콘솔에 찍히는지 확인!

              await onSave();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 54),
              backgroundColor: Colors.blue,
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

  Future<Directory> bookImagesDir() async {
    final base = await getTemporaryDirectory(); // 임시보관
    final dir = Directory(p.join(base.path, 'book_images'));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<List<String>> saveXFilesToLocal(List<XFile> files) async {
    final dir = await bookImagesDir();
    final List<String> saved = [];

    for (final x in files) {
      final ext = p.extension(x.path);
      final fileName =
          'book_${DateTime.now().millisecondsSinceEpoch}_${saved.length}$ext';
      final destPath = p.join(dir.path, fileName);
      // 파일 복사
      await File(x.path).copy(destPath);
      saved.add(destPath);
    }
    return saved;
  }

  /// [저장 로직]
  Future<void> onSave() async {
    // 유효성 체크
    final ok = vaildcheck(
      titleController.text,
      authorController.text,
      desController.text,
      priceController.text,
    );
    if (!ok) return;

    // 이미지 로컬 복사
    final savedPaths = await saveXFilesToLocal(images);

    BookEntity data = BookEntity(
      title: titleController.text,
      author: authorController.text,
      price: int.parse(priceController.text.replaceAll(',', '')),
      description: desController.text,
      images: savedPaths,
    );

    if (!mounted) return;
    Navigator.pop(context, data);
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
