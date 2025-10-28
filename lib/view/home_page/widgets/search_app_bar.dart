import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final TextEditingController searchController;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onStartSearch;
  final VoidCallback onEndSearch;
  final VoidCallback onCartPressed;

  const SearchAppBar({
    super.key,
    required this.isSearching,
    required this.searchController,
    required this.onQueryChanged,
    required this.onStartSearch,
    required this.onEndSearch,
    required this.onCartPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: isSearching
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
          : const Text(
              'REBook',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
      leading: isSearching
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onEndSearch,
            )
          : null,
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
