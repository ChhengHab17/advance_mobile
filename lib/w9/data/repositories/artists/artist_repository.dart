import 'package:advance_flutter/w9/model/artist/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();

  Future<Artist?> fetchArtistById(String id);
}
