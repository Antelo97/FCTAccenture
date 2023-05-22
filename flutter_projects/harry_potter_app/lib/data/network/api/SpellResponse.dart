import 'dart:developer';

import 'package:harry_potter_app/constants.dart';
import 'package:harry_potter_app/data/network/model_response/SpellResponse.dart';
import 'package:http/http.dart' as http;

class SpellService {
  Future<List<SpellResponse>?> getSpells() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrlSecondApi + ApiConstants.spellsEndpoint);
      var jsonResponse = await http.get(url);
      if (jsonResponse.statusCode == 200) {
        List<SpellResponse> objectResponse =
            spellResponseFromJson(jsonResponse.body);
        return objectResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
