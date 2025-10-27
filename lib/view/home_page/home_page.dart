import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  final List<Map<String, String>> books = [
    {'title': '도서명1', 'price': '25,000원'},
    {'title': '도서명2', 'price': '16,000원'},
    {'title': '도서명3', 'price': '9,000원'},
    {'title': '도서명4', 'price': '30,000원'},
    {'title': '도서명5', 'price': '12,000원'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        title: Text('REBook'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Material(
            color: Colors.transparent, 
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () { },
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text('image', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    SizedBox(width: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book['title']!, style: TextStyle(fontSize: 28)),
                        Text(book['price']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 152, 155, 156),
      ),
    );
  }
}
