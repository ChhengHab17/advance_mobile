import 'package:advance_flutter/w10/model/comment/comment.dart';
import 'package:advance_flutter/w10/model/songs/song.dart';

import '../../../model/artist/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists({bool forceFetch});

  Future<Artist?> fetchArtistById(String id);
  Future<List<Song>> fetchArtistSongs(String artistId);
  Future<List<Comment>> fetchArtistComments(String artistId);
  Future<void> postComment(String artistId, String text);
}
