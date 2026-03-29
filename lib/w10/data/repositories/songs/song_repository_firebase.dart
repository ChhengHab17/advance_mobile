import 'dart:convert';

import 'package:advance_flutter/w10/config/uri_config.dart';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {

  final Uri songsUri = Uriconfig.baseUri.replace(path: '/songs.json');
  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    if (_cachedSongs != null && !forceFetch) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      _cachedSongs = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<void> likeSong(String songId) async {
    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> songJson = json.decode(response.body);
      for (final song in songJson.entries) {
        if (song.key == songId) {
          final currLike = song.value['likes'];
          final Uri patchSongsUri = Uriconfig.baseUri.replace(
            path: '/songs/$songId.json',
          );

          final patchRes = await http.patch(
            patchSongsUri,
            body: jsonEncode({'likes': currLike + 1}),
          );

          if (patchRes.statusCode != 200) {
            throw Exception('Failed like song');
          }
          _cachedSongs = null;
          return;
        }
      }
      throw Exception("Song not found");
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
