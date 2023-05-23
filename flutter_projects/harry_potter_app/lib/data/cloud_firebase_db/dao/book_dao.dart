import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/cloud_constants.dart';
import 'package:harry_potter_app/data/cloud_firebase_db/model_collection/book_collection.dart';
import 'package:harry_potter_app/data/network/api/book_service.dart';

class BookDao {
  final api = BookService();
  final booksCollection = FirebaseFirestore.instance.collection('books');

  static final BookDao _shared = BookDao._sharedInstance();
  BookDao._sharedInstance(); // Private constructor
  factory BookDao() => _shared;

  Future<List<BookCollection>> getBooksFromApi() async {
    final books = await api.getBooks();

    if (books!.isNotEmpty) {
      deleteBooks();
      insertBooks();
      return books.map((e) => BookCollection.fromResponse(e)).toList();
    } else {
      return getBooksFromCloudFirebase();
    }
  }

  Future<List<BookCollection>> getBooksFromCloudFirebase() async {
    return await booksCollection.get().then((snapshot) =>
        snapshot.docs.map((doc) => BookCollection.fromSnapshot(doc)).toList());

    // return booksCollection.snapshots().map((event) =>
    //     event.docs.map((doc) => BookCollection.fromSnapshot(doc)).toList());
  }

  Future<void> insertBooks() async {
    final books = await api.getBooks();
    final batch = FirebaseFirestore.instance.batch();

    for (var book in books!) {
      final bookRef = FirebaseFirestore.instance.collection('books').doc();
      batch.set(bookRef, book.toJson());
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

  Future<List<BookCollection>> searchBooksByTitle(String searchQuery) async {
    return await booksCollection
        .where(titleFieldName,
            isGreaterThanOrEqualTo: searchQuery.toLowerCase())
        .where(titleFieldName,
            isLessThanOrEqualTo: '${searchQuery.toLowerCase()}\uf8ff')
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => BookCollection.fromSnapshot(doc))
            .toList());
  }

  Future<void> updateBook(BookCollection book) async {
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

    List<BookCollection> sortBooksByTitle(List<BookCollection> books) {
      books.sort((a, b) => a.title.compareTo(b.title));
      return books;
    }
  }

  List<BookCollection> sortBooksByTitleAsc(List<BookCollection> books) {
    books.sort(
        (oneBook, anotherBook) => oneBook.title.compareTo(anotherBook.title));
    return books;
  }

  List<BookCollection> sortBooksByTitleDesc(List<BookCollection> books) {
    books.sort(
        (oneBook, anotherBook) => anotherBook.title.compareTo(oneBook.title));
    return books;
  }
}
