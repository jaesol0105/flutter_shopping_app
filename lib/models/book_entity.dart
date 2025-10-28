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

  /** 객체 비교를 위한 비교연산자와 해쉬코드 
   * 뒤늦게 id를 추가하는 작업을 하기엔 체력이 고갈돼서 못하고 이렇게라도 하게되었음 ㅜ.ㅜ 흑흑 */
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BookEntity &&
        other.title == title &&
        other.author == author &&
        other.price == price &&
        other.description == description;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      author.hashCode ^
      price.hashCode ^
      (description?.hashCode ?? 0);
}

// 책과 수량
class CartItem {
  final BookEntity book;
  int count;
  CartItem({required this.book, required this.count});

  // copyWith 필요한 값만 덮어쓰기 용도로 사용. 그래서 optional parameter 사용.
  CartItem copyWith({BookEntity? book, int? count}) =>
      CartItem(book: book ?? this.book, count: count ?? this.count);

  int getTotal() => book.price * count;
}
