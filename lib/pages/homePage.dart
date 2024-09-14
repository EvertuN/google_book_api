import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app/data/models/modelProduct.dart';
import '../utilis/customColor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BookModel> books = [];
  String query = '';

  Future<void> fetchBooks(String query) async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

    if (response.statusCode == 200) {
        final data = json.decode(response.body);
      setState(() {
        books = (data['items'] as List)
            .where((item) => item['volumeInfo'] != null)
            .map((item) => BookModel.fromMap(item['volumeInfo']))
            .toList();
      });
    } else {
      throw Exception('Falha ao carregar os livros');
    }
  }

  void _onSearch() {
    if (query.isNotEmpty) {
      fetchBooks(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.primaryColor,
        title: const Text(
          'Livros API',
          style: TextStyle(
            color: CustomColors.appbartextcolor,
          ),
        ),
        elevation: 5,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Procurar livros...',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                query = value;
              },
              onFieldSubmitted: (value) {
                _onSearch();
              },
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: books.isEmpty
                  ? const Center(child: Text('Nenhum livro encontrado'))
                  : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return ListTile(
                    leading: Image.network(
                      book.thumbnail,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.book),
                      width: 50,
                    ),
                    title: Text(book.title),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
