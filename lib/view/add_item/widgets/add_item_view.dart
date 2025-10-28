import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_3/view/add_item/widgets/photo_picker_row_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddItemView extends StatelessWidget {
  /// [상품 정보 입력 위젯]
  const AddItemView({
    super.key,
    required this.titleController,
    required this.authorController,
    required this.desController,
    required this.priceController,
    required this.images,
    required this.addImageToLocal,
    required this.removeImageAt,
    this.maxCount = 10,
  });

  final TextEditingController titleController;
  final TextEditingController authorController;
  final TextEditingController desController;
  final TextEditingController priceController;
  final List<XFile> images;
  final void Function(Iterable<XFile>) addImageToLocal;
  final void Function(int) removeImageAt;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 사진 등록
        titleLabel("사진 등록(${images.length}/10)"),
        SizedBox(height: 5),
        PhotoPickerRowView(
          images: images,
          addImageToLocal: addImageToLocal,
          removeImageAt: removeImageAt,
          maxCount: maxCount,
        ),
        SizedBox(height: 30),

        // 도서명
        titleLabel("도서명"),
        SizedBox(height: 5),
        TextField(
          controller: titleController,
          maxLength: 30,
          maxLines: 1,
          decoration: styleInputDecoration().copyWith(hintText: '도서명을 입력하세요.'),
        ),
        SizedBox(height: 30),

        // 저자명
        titleLabel("저자명"),
        SizedBox(height: 5),
        TextField(
          controller: authorController,
          maxLength: 30,
          maxLines: 1,
          decoration: styleInputDecoration().copyWith(hintText: '저자명을 입력하세요.'),
        ),
        SizedBox(height: 30),

        // 설명
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

        // 가격
        titleLabel("가격"),
        SizedBox(height: 5),
        Stack(
          children: [
            TextField(
              controller: priceController,
              maxLength: 10,
              inputFormatters: <TextInputFormatter>[
                CurrencyTextInputFormatter.currency(
                  decimalDigits: 0,
                  symbol: "",
                ),
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
                    "${NumberFormat('#,###').format(int.tryParse(priceController.text.replaceAll(',', '')) ?? 0)} 원",
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
}
