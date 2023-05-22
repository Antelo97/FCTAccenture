import 'dart:convert';

List<SpellResponse> spellResponseFromJson(String str) =>
    List<SpellResponse>.from(
        json.decode(str).map((x) => SpellResponse.fromJson(x)));

String spellResponseToJson(List<SpellResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpellResponse {
  String idApi;
  String name;
  String description;

  SpellResponse({
    required this.idApi,
    required this.name,
    required this.description,
  });

  factory SpellResponse.fromJson(Map<String, dynamic> json) => SpellResponse(
        idApi: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": idApi,
        "name": name,
        "description": description,
      };
}
