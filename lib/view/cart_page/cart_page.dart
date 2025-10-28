import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/cart_page/cart_list_view.dart';
import 'package:flutter_project_3/view/cart_page/empty_cart.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key, required this.cartItemList});
  List<CartItem> cartItemList;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> cart;
  late Set<int> selected; // 체크 상태

  @override
  void initState() {
    super.initState();
    cart = List<CartItem>.from(widget.cartItemList);
    selected = {};
  }

  // 아이템 제거
  void removeItem(int index) {
    setState(() {
      cart.removeAt(index);
      selected.remove(index);
    });
  }

  // 아이템 수량 변경
  void updateCount(int index, int newCount) {
    // 책 수량 1 보다 작아지지 않음
    final int minCount = newCount < 1 ? 1 : newCount;
    setState(() {
      cart[index] = cart[index].copyWith(count: minCount);
    });
  }

  // 아이템 체크박스
  void itemCheck(int index, bool isChecked) {
    setState(() {
      if (selected.contains(index)) {
        selected.remove(index);
      } else {
        selected.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('장바구니'), elevation: 1),
      body: widget.cartItemList.isEmpty
          ? EmptyCart()
          : CartListView(
              cartItems: cart,
              selectedItems: selected,
              onRemove: removeItem,
              onUpdateCount: updateCount,
              onItemCheck: itemCheck,
            ),
    );
  }
}
