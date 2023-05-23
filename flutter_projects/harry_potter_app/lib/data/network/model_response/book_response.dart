import 'dart:convert';

List<BookResponse> bookResponseFromJson(String str) => List<BookResponse>.from(
    json.decode(str).map((x) => BookResponse.fromJson(x)));

String bookResponseToJson(List<BookResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookResponse {
  int idApi;
  String title;
  String imageUrl;
  List<ArtistResponse> artists;
  String releaseDate;

  BookResponse({
    required this.idApi,
    required this.title,
    required this.imageUrl,
    required this.artists,
    required this.releaseDate,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
        idApi: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        artists: List<ArtistResponse>.from(
            json["artists"].map((x) => ArtistResponse.fromJson(x))),
        releaseDate: json["release_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": idApi,
        "title": title,
        "image_url": imageUrl,
        "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
        "release_date": releaseDate,
      };
}

class ArtistResponse {
  AuthorResponse author;

  ArtistResponse({
    required this.author,
  });

  factory ArtistResponse.fromJson(Map<String, dynamic> json) => ArtistResponse(
        author: AuthorResponse.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author.toJson(),
      };
}

class AuthorResponse {
  int id;
  String name;

  AuthorResponse({
    required this.id,
    required this.name,
  });

  factory AuthorResponse.fromJson(Map<String, dynamic> json) => AuthorResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
