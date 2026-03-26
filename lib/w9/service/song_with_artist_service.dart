import 'package:advance_flutter/w9/data/repositories/artists/artist_repository.dart';
import 'package:advance_flutter/w9/data/repositories/songs/song_repository.dart';
import 'package:advance_flutter/w9/model/songs/song.dart';
import 'package:advance_flutter/w9/model/songs/song_with_artist.dart';

class SongWithArtistService {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  SongWithArtistService({
    required this.songRepository,
    required this.artistRepository,
  });

  Future<List<SongWithArtist>> getSongsWithArtist() async {
    final List<Song> songs = await songRepository.fetchSongs();
    final List<SongWithArtist> result = [];

    for (final song in songs) {
      final artist = await artistRepository.fetchArtistById(song.artistId);
      if (artist != null) {
        result.add(SongWithArtist(song: song, artist: artist));
      }
    }
    return result;
  }
}
