import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerRowView extends StatefulWidget {
  const PhotoPickerRowView({super.key, required this.addImageToLocal});

  final void Function(Iterable<XFile>) addImageToLocal;

  @override
  State<PhotoPickerRowView> createState() => _PhotoPickerRowViewState();
}

class _PhotoPickerRowViewState extends State<PhotoPickerRowView> {
  int maxCount = 10;
  final List<XFile> _images = [];

  /// [업로드할 이미지 선택]
  Future<void> _pickPhoto() async {
    final remain = maxCount - _images.length;

    // 사진 선택 (최대 10개 제한)
    final picked = await ImagePicker().pickMultiImage(
      limit: remain,
      imageQuality: 85,
      requestFullMetadata: false,
    );

    if (picked == null || picked.isEmpty) return;

    /* 남은 수만큼만 추가
      (remain 동작안할 경우를 대비해서 수동으로 예외처리) */
    final addList = picked.take(remain);

    setState(() {
      _images.addAll(addList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ableToAdd = _images.length < maxCount;
    final itemCount = _images.length + 1;

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8),
        itemBuilder: (context, index) {
          // 첫번째 인덱스
          if (index == 0) {
            return _AddPhoto(onTap: _pickPhoto, ableToAdd: ableToAdd);
          }

          final img = _images[index - 1];

          // 나머지 인덱스
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                // 썸네일
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.file(File(img.path), fit: BoxFit.cover),
                ),
                // 삭제 버튼
                Positioned(
                  top: 4,
                  right: 4,
                  child: InkWell(
                    onTap: () {
                      setState(() => _images.removeAt(index - 1));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// [이미지 추가 버튼]
class _AddPhoto extends StatelessWidget {
  const _AddPhoto({required this.onTap, required this.ableToAdd});
  final VoidCallback onTap;
  final bool ableToAdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ableToAdd ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            Icons.camera_alt_rounded,
            size: 24,
            color: ableToAdd ? Colors.black45 : Colors.grey,
          ),
        ),
      ),
    );
  }
}
