import 'package:harry_potter_app/data/network/api/book_service.dart';

void main() async {
  final api = BookService();
  final books = await api.getBooks();
  for (final book in books!) {}
}
