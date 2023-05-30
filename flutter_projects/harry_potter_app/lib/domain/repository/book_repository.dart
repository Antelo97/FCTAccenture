import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/network/api/book_service.dart';
import 'package:harry_potter_app/domain/model/book.dart';

class BookRepository {
  final api = BookService();
  final booksCollection = FirebaseFirestore.instance.collection('books');

  static final BookRepository _shared = BookRepository._sharedInstance();
  BookRepository._sharedInstance(); // Private constructor
  factory BookRepository() => _shared;

  Future<List<Book>> loadBooksFromApi() async {
    print('doneuwu00');

    final books = await getBooksFromCloudFirebase();
    print('doneuwu01');

    if (books.isEmpty) {
      insertBooks();
      return getBooksFromCloudFirebase();
    } else {
      // deleteBooks();
      // insertBooks(); (podría ser interesante en caso de actualizarse la API)
      return books;
    }
  }

  Future<List<Book>> getBooksFromCloudFirebase() async {
    // Importante tener en cuenta que al crear una colección ya existe por defecto un documento
    final snapshot = await booksCollection.get();
    try {
      if (snapshot.docs.length > 2) {
        print('donehereeee');
        return snapshot.docs.map((doc) => Book.fromDocument(doc)).toList();
      }
      return [];
    } catch (e) {
      throw e;
    }

    // return booksCollection.snapshots().map((event) =>
    //     event.docs.map((doc) => BookCollection.fromSnapshot(doc)).toList());
  }

  Future<void> insertBooks() async {
    final booksResponse = await api.getBooks();
    final books = booksResponse!
        .map((bookResponse) => Book.fromResponse(bookResponse))
        .toList();
    final batch = FirebaseFirestore.instance.batch();

    for (var book in books) {
      final bookRef = booksCollection.doc();
      batch.set(
        bookRef,
        book.toMap(),
      );
    }

    await batch.commit();
  }

  Future<void> deleteBooks() async {
    final snapshot = await booksCollection.get();
    final batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<List<Book>> searchBooksByTitle(String searchQuery) async {
    return await booksCollection
        .where(titleFieldName,
            isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(titleFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) =>
            snapshot.docs.map((doc) => Book.fromDocument(doc)).toList());
  }

  Future<void> updateBook(Book book) async {
    try {
      await booksCollection.doc(book.idDocument).update({
        idApiBookFieldName: book.idApiBook,
        titleFieldName: book.title,
        imageUrlFieldName: book.imageUrl,
        authorFieldName: book.author,
        releaseDateFieldName: book.releaseDate,
      });
    } catch (e) {
      // CouldNotUpdateNoteException();
    }
  }

  List<Book> sortBooksByTitleAsc(List<Book> books) {
    books.sort(
        (oneBook, anotherBook) => oneBook.title.compareTo(anotherBook.title));
    return books;
  }

  List<Book> sortBooksByTitleDesc(List<Book> books) {
    books.sort(
        (oneBook, anotherBook) => anotherBook.title.compareTo(oneBook.title));
    return books;
  }
}
