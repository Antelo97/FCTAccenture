import 'dart:developer';

import 'package:harry_potter_app/constants.dart';
import 'package:harry_potter_app/data/network/model_response/SpeciesResponse.dart';
import 'package:http/http.dart' as http;

class SpeciesService {
  Future<List<SpeciesResponse>?> getSpecies() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrlFirstApi + ApiConstants.speciesEndpoint);
      var jsonResponse = await http.get(url);
      if (jsonResponse.statusCode == 200) {
        List<SpeciesResponse> objectResponse =
            speciesResponseFromJson(jsonResponse.body);
        return objectResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
