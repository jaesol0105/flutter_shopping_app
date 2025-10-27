import 'package:flutter/material.dart';
import 'package:flutter_project_3/view/cart_page/cart_list_view.dart';
import 'package:flutter_project_3/view/cart_page/empty_cart.dart';

class BookEntity {
  final String title;
  final String author;
  final String? description;
  final String? image;
  final int price;
  final int count;
  final bool isChecked;

  BookEntity({
    required this.title,
    required this.author,
    this.description,
    this.image,
    required this.price,
    required this.count,
    this.isChecked = false,
  });

  // 코드 간소화
  BookEntity copyWith({
    String? title,
    String? author,
    String? description,
    String? image,
    int? price,
    int? count,
    bool? isChecked,
  }) {
    return BookEntity(
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      count: count ?? this.count,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<BookEntity> cart = [
    // 예시임
    BookEntity(
      title: "토맛 토마토",
      author: "토마토맛 토",
      price: 99999,
      count: 1,
      image: "",
      isChecked: false,
    ),
  ];

  void removeItem(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  // 책 수량 1 보다 작아지지 않음
  void updateCount(int index, int newCount) {
    int minCount = newCount < 1 ? 1 : newCount;
    setState(() {
      cart[index] = cart[index].copyWith(count: minCount);
    });
  }

  // 아이템 체크박스
  void ItemCheck(int index, bool isChecked) {
    setState(() {
      cart[index] = cart[index].copyWith(isChecked: isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('장바구니'), elevation: 1),
      body: cart.isEmpty
          ? EmptyCart()
          : CartListView(
              cartItems: cart,
              onRemove: removeItem,
              onUpdateCount: updateCount,
              onItemCheck: ItemCheck,
            ),
    );
  }
}
