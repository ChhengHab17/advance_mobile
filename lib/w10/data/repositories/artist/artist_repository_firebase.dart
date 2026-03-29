import 'dart:convert';

import 'package:advance_flutter/w10/config/uri_config.dart';
import 'package:advance_flutter/w10/data/dtos/comment_dto.dart';
import 'package:advance_flutter/w10/data/dtos/song_dto.dart';
import 'package:advance_flutter/w10/model/comment/comment.dart';
import 'package:advance_flutter/w10/model/songs/song.dart';
import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistsUri = Uriconfig.baseUri.replace(path: '/artists.json');
  List<Artist>? _cachedArtists;

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    if (_cachedArtists != null && !forceFetch) {
      return _cachedArtists!;
    }
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Artist> result = [];
      for (final entry in songJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }
      _cachedArtists = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}

  @override
  Future<List<Song>> fetchArtistSongs(String artistId) async {
    final songUri = Uriconfig.baseUri.replace(path: '/songs.json');
    final http.Response response = await http.get(songUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        if (entry.value['artistId'] == artistId) {
          result.add(SongDto.fromJson(entry.key, entry.value));
        }
      }
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load artist songs');
    }
  }

  @override
  Future<List<Comment>> fetchArtistComments(String artistId) async {
    final commentUri = Uriconfig.baseUri.replace(
      path: '/artists/$artistId/comments.json',
    );
    final http.Response response = await http.get(commentUri);
    if (response.statusCode == 200) {
      if (response.body == 'null') return [];
      Map<String, dynamic> commentJson = json.decode(response.body);
      List<Comment> result = [];
      for (final entry in commentJson.entries) {
        result.add(CommentDto.fromJson(entry.key, entry.value));
      }
      return result;
    } else {
      throw Exception('Failed to load artist comments');
    }
  }

  @override
  Future<void> postComment(String artistId, String text) async {
    final commentUri = Uriconfig.baseUri.replace(
      path: '/artists/$artistId/comments.json',
    );
    final Comment comment = Comment(id: '', commentText: text);
    final http.Response response = await http.post(
      commentUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(CommentDto.toJson(comment)),
    );

    if (response.statusCode != 200) throw Exception('Failed to post comment');
  }
}
