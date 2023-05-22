import 'dart:developer';

import 'package:harry_potter_app/constants.dart';
import 'package:harry_potter_app/data/network/model_response/character_response.dart';
import 'package:http/http.dart' as http;

class CharacterService {
  Future<List<CharacterResponse>?> getCharacters() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrlSecondApi + ApiConstants.charactersEndpoint);
      var jsonResponse = await http.get(url);
      if (jsonResponse.statusCode == 200) {
        List<CharacterResponse> objectResponse =
            characterResponseFromJson(jsonResponse.body);
        return objectResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
