import 'dart:convert';

List<SpeciesResponse> speciesResponseFromJson(String str) =>
    List<SpeciesResponse>.from(
        json.decode(str).map((x) => SpeciesResponse.fromJson(x)));

String speciesResponseToJson(List<SpeciesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpeciesResponse {
  int idApi;
  String name;
  String? native;

  SpeciesResponse({
    required this.idApi,
    required this.name,
    this.native,
  });

  factory SpeciesResponse.fromJson(Map<String, dynamic> json) =>
      SpeciesResponse(
        idApi: json["id"],
        name: json["name"],
        native: json["native"],
      );

  Map<String, dynamic> toJson() => {
        "id": idApi,
        "name": name,
        "native": native,
      };
}
