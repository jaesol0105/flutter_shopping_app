import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/add_item/add_item_page.dart';
import 'package:flutter_project_3/view/cart_page/cart_page.dart';
import 'package:flutter_project_3/view/detail_page/book_detail_page.dart';
import 'package:flutter_project_3/view/home_page/widgets/book_list_section.dart';
import 'package:flutter_project_3/view/home_page/widgets/book_list_view.dart';
import 'package:flutter_project_3/view/home_page/widgets/empty_view.dart';
import 'package:flutter_project_3/view/home_page/widgets/search_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookEntity> bookList = []; // 상품(도서) 데이터
  List<CartItem> cartList = []; // 장바구니 데이터

  bool isSearching = false; // 검색 중?
  String query = ''; // 검색 쿼리
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showingBooks = _filteredBooks;
    final mappedIndexes = _filteredIndexes;

    return PopScope(
      canPop: !isSearching, // 검색 중일 땐 pop 방지
      onPopInvokedWithResult: (didPop, result) {
        // 검색중 pop 한 경우 검색 창 닫기
        if (!didPop && isSearching) {
          setState(() {
            isSearching = false;
            query = '';
            _searchController.clear();
          });
        }
      },
      child: Scaffold(
        appBar: SearchAppBar(
          isSearching: isSearching,
          searchController: _searchController,
          onQueryChanged: (v) => setState(() => query = v),
          onStartSearch: _startSearch,
          onEndSearch: _endSearch,
          onCartPressed: navigateToCart,
        ),

        // 상품 목록
        body: showingBooks.isEmpty
            ? (bookList.isEmpty
                  ? const EmptyView(text: '상품이 없습니다.')
                  : const EmptyView(text: '검색 결과가 없습니다.'))
            : BookListSection(
                bookList: showingBooks,
                onNavigateToDetail: (filteredIndex) =>
                    navigateToDetail(mappedIndexes[filteredIndex]),
              ),

        // 상품 추가
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToAddItem(),
          shape: const CircleBorder(),
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
    );
  }

  /// [상품 상세 페이지로 이동]
  Future<void> navigateToDetail(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(
          key: UniqueKey(),
          book: bookList[index],
          index: index,
          addBookToCartList: addBookToCartList,
          navigateToCart: navigateToCart,
        ),
      ),
    );
  }

  /// [상품 추가 페이지로 이동]
  Future<void> navigateToAddItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemPage()),
    );
    setState(() => bookList.add(result));
  }

  /// [장바구니 페이지로 이동]
  Future<void> navigateToCart() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          cartItemList: cartList,
          removeBookToCartList: removeBookToCartList,
          editBookCountInCart: editBookCountInCart,
        ),
      ),
    );
  }

  // [장바구니에 상품 추가]
  void addBookToCartList(BookEntity book, int count) {
    final existingIndex = cartList.indexWhere((item) => item.book == book);
    if (existingIndex != -1) {
      // 이미 존재할 경우 수량만 증가
      cartList[existingIndex].count += count;
    } else {
      // 존재하지 않으면 새로 추가
      cartList.add(CartItem(book: book, count: count));
    }
  }

  // [장바구니에서 상품 제거]
  void removeBookToCartList(int index) {
    setState(() {
      cartList.removeAt(index);
    });
  }

  // [장바구니에 담긴 상품 수량 변경]
  void editBookCountInCart(int index, int count) {
    setState(() {
      cartList[index].count = count;
    });
  }

  /// [검색 필터링 : 인덱스 배열 반환]
  List<int> get _filteredIndexes {
    // 검색중이 아닐 경우 또는 검색창에 아무것도 안친 상태
    if (!isSearching || query.trim().isEmpty) {
      return List<int>.generate(bookList.length, (i) => i); // 전체 index 배열 반환
    }
    final q = query.toLowerCase();
    return List<int>.generate(bookList.length, (i) => i)
        .where((i) => bookList[i].title.toLowerCase().contains(q))
        .toList(); // 필터링 걸리는 index 배열 반환
  }

  /// [인덱스로 bookList 매핑]
  List<BookEntity> get _filteredBooks =>
      _filteredIndexes.map((i) => bookList[i]).toList();

  /// [검색 시작]
  void _startSearch() => setState(() => isSearching = true);

  /// [검색 종료]
  void _endSearch() {
    setState(() {
      isSearching = false;
      query = '';
      _searchController.clear();
    });
  }
}
