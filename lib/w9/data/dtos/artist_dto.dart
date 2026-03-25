import 'package:advance_flutter/w9/model/artist/artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = 'genre';
  static const String imageUrlKey = 'imageUrl';

  static Artist fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey] is String);
    assert(json[genreKey] is String);
    assert(json[imageUrlKey] is String);

    return Artist(
      name: json[nameKey],
      genre: json[genreKey],
      imageUrl: Uri.parse(json[imageUrlKey]),
      id: id,
    );
  }
  Map<String, dynamic> toJson(Artist artist) {
    return {
      nameKey: artist.name,
      genreKey: artist.genre,
      imageUrlKey: artist.imageUrl.toString(),
    };
  }
}
