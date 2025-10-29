import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// [검색 기능이 포함된 커스텀 앱 바]
  const SearchAppBar({
    super.key,
    required this.isSearching,
    required this.searchController,
    required this.onQueryChanged,
    required this.onStartSearch,
    required this.onEndSearch,
    required this.onCartPressed,
  });

  final bool isSearching;
  final TextEditingController searchController;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onStartSearch;
  final VoidCallback onEndSearch;
  final VoidCallback onCartPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: isSearching
          // 검색 중일 때
          ? TextField(
              controller: searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: '제목으로 검색',
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 18),
              cursorColor: Colors.white,
              onChanged: onQueryChanged,
            )
          // 기본 상태일 때
          : const Text(
              'REBook',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

      // 검색 중일 때 백버튼
      leading: isSearching
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onEndSearch,
            )
          : null,

      // 상단 메뉴 버튼
      actions: [
        if (!isSearching)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: onStartSearch,
          )
        else
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              searchController.clear();
              onQueryChanged('');
            },
          ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: onCartPressed,
        ),
      ],
    );
  }
}
