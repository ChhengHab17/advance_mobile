import 'dart:convert';

import 'package:advance_flutter/w9/data/dtos/artist_dto.dart';
import 'package:advance_flutter/w9/data/repositories/artists/artist_repository.dart';
import 'package:advance_flutter/w9/data/repositories/songs/song_repository_firebase.dart';
import 'package:advance_flutter/w9/model/artist/artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase extends ArtistRepository {
  static final Uri artistUri = SongRepositoryFirebase.baseUri.replace(
    path: "artists.json",
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> artistJson = json.decode(response.body);
      List<Artist> result = [];

      for (var iterable in artistJson.entries) {
        String id = iterable.key;
        Map<String, dynamic> data = iterable.value;
        result.add(ArtistDto.fromJson(id, data));
      }

      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load artists');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}
}
