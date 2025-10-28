class BookEntity {
  final String title;
  final String? description;
  final String author;
  final List<String>? images;
  final int price;

  BookEntity({
    required this.title,
    this.description,
    required this.author,
    this.images,
    required this.price,
  });
}

// 책과 수량
class CartItem {
  final BookEntity book;
  final int count;
  const CartItem({required this.book, required this.count});

  // copyWith 필요한 값만 덮어쓰기 용도로 사용. 그래서 optional parameter 사용.
  CartItem copyWith({BookEntity? book, int? count}) =>
      CartItem(book: book ?? this.book, count: count ?? this.count);

  int getTotal() => book.price * count;
}
