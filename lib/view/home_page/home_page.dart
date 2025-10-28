import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/add_item/add_item_page.dart';
import 'package:flutter_project_3/view/cart_page/cart_page.dart';
import 'package:flutter_project_3/view/detail_page/book_detail_page.dart';
import 'package:flutter_project_3/view/home_page/widgets/book_list_view.dart';
import 'package:flutter_project_3/view/home_page/widgets/empty_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookEntity> bookList = [
    BookEntity(title: '도서명1', author: '재솔', price: 25000),
    BookEntity(title: '도서명2', author: '재솔', price: 16000),
  ]; // 상품(도서) 데이터

  List<CartItem> cartList = []; // 장바구니 데이터

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'REBook',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () => navigateToCart(),
          ),
        ],
      ),

      // 상품 목록
      body: bookList.isEmpty
          ? EmptyView()
          : BookListView(
              key: UniqueKey(),
              bookList: bookList,
              onNavigateToDetail: navigateToDetail,
            ),

      // 상품 추가
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToAddItem(),
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 35, color: Colors.white),
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
}
