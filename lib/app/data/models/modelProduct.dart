class BookModel {
  final String title;
  // final String categories;
  // final String authors;
  // final DateTime publishedDate; //A API USA O FORMATO YYYY-MM-DD, provavelmente vai dar erro
  // final int pageCount;
  // final String description;
  final String thumbnail;

  BookModel({
    required this.title,
    // required this.categories,
    // required this.authors,
    // required this.publishedDate,
    // required this.pageCount,
    // required this.description,
    required this.thumbnail,
  });
//SIKE
  factory BookModel.fromMap(Map<String, dynamic> map){
    String title = map['title'] ?? 'No title available';
    String thumbnail = (map['imageLinks'] != null && map['imageLinks']['thumbnail'] != null)
        ? map['imageLinks']['thumbnail']
        : 'https://via.placeholder.com/150';


    return BookModel(
      title: title,
      thumbnail: thumbnail,
    );
  }
}
