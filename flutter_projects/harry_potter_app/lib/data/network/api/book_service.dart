import 'dart:developer';

import 'package:harry_potter_app/data/network/api_constants.dart';
import 'package:harry_potter_app/data/network/model_response/book_response.dart';
import 'package:http/http.dart' as http;

class BookService {
  Future<List<BookResponse>?> getBooks() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrlFirstApi + ApiConstants.booksEndpoint);
      var jsonResponse = await http.get(url);
      if (jsonResponse.statusCode == 200) {
        List<BookResponse> objectResponse =
            bookResponseFromJson(jsonResponse.body);
        return objectResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
