import 'package:flutter/material.dart';
import 'package:flutter_project_3/view/cart_page/cart_list_view.dart';
import 'package:flutter_project_3/view/cart_page/empty_cart.dart';

class CartEntity {
  final String name;
  final String? image; // 이거 어떻게 해야할지 모르겠음 사진임
  final int price;
  final int howMany;

  CartEntity({
    required this.name,
    this.image,
    required this.price,
    required this.howMany,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartEntity> cart = [
    // 예시임
    CartEntity(name: "토맛 토마토", image: "", price: 99999, howMany: 1),
    CartEntity(name: "토마토맛 토", image: "", price: 88888, howMany: 2),
    CartEntity(name: "토마토맛 토", image: "", price: 88888, howMany: 2),
  ];

  void removeCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  // 책 수량 0 보다 작아지지 않음
  void updateHowMany(int index, int newHowMany) {
    int zeroHowMany = newHowMany < 0 ? 0 : newHowMany;
    setState(() {
      cart[index] = CartEntity(
        name: cart[index].name,
        image: cart[index].image,
        price: cart[index].price,
        howMany: zeroHowMany,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('장바구니'),
        elevation: 1,
      ),
      body: cart.isEmpty
          ? EmptyCart()
          : CartListView(
              cartItems: cart,
              onRemove: removeCart,
              onUpdateHowMany: updateHowMany,
            ),
    );
  }
}
