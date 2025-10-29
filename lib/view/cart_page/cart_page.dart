import 'package:flutter/material.dart';
import 'package:flutter_project_3/models/book_entity.dart';
import 'package:flutter_project_3/view/cart_page/widgets/cart_list_view.dart';
import 'package:flutter_project_3/view/cart_page/widgets/empty_cart.dart';

class CartPage extends StatefulWidget {
  CartPage({
    super.key,
    required this.cartList,
    required this.onRemoveBookToCartList,
    required this.onEditBookCountInCartList,
  });

  List<CartItem> cartList;
  final void Function(int) onRemoveBookToCartList;
  final void Function(int, int) onEditBookCountInCartList;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Set<int> selected; // 체크 상태

  @override
  void initState() {
    super.initState();
    selected = {};
  }

  /// [카트에서 아이템 제거]
  void removeItem(int index) {
    setState(() {
      widget.onRemoveBookToCartList(index);
      /** 엔티티에 id 만들 기력이 없어서 추가한 코드...
         selectedItemsPrice()에서 사라진 인덱스를 읽는걸 방지 */
      selected = selected
          .where((i) => i != index)
          .map((i) => i > index ? i - 1 : i)
          .where((i) => i >= 0 && i < widget.cartList.length)
          .toSet();
    });
  }

  /// [아이템 수량 변경]
  void updateCount(int index, int newCount) {
    // 책 수량 1 보다 작아지지 않음
    final int minCount = newCount < 1 ? 1 : newCount;
    setState(() {
      widget.onEditBookCountInCartList(index, minCount);
    });
  }

  /// [아이템 체크박스 토글]
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
      appBar: AppBar(title: Text('장바구니')),
      body: widget.cartList.isEmpty
          ? EmptyCart()
          : CartListView(
              cartItems: widget.cartList,
              selectedItems: selected,
              onRemoveItem: removeItem,
              onUpdateCount: updateCount,
              onItemCheck: itemCheck,
            ),
    );
  }
}
