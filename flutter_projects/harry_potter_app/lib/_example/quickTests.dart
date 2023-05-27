import 'dart:async';

import 'package:harry_potter_app/data/network/api/book_service.dart';
import 'package:harry_potter_app/domain/model/auth_user.dart';

void main() async {
  final api = BookService();
  final books = await api.getBooks();
  for (final book in books!) {
    print(book.title + '\na  ');
  }
}
