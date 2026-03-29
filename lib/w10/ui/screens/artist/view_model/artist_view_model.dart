import 'package:advance_flutter/w10/model/comment/comment.dart';
import 'package:advance_flutter/w10/model/songs/song.dart';
import 'package:advance_flutter/w10/data/repositories/artist/artist_repository.dart';
import 'package:advance_flutter/w10/model/artist/artist.dart';
import 'package:advance_flutter/w10/ui/utils/async_value.dart';
import 'package:flutter/material.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final Artist artist;

  AsyncValue<List<Song>> songs = AsyncValue.loading();
  AsyncValue<List<Comment>> comments = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository, required this.artist}) {
    fetchData();
  }

  void fetchData() async {
    songs = AsyncValue.loading();
    comments = AsyncValue.loading();
    notifyListeners();

    try {
      final List<Song> fetchedSongs = await artistRepository.fetchArtistSongs(
        artist.id,
      );
      songs = AsyncValue.success(fetchedSongs);
    } catch (e) {
      songs = AsyncValue.error(e);
    }
    notifyListeners();

    try {
      final List<Comment> fetchedComments = await artistRepository
          .fetchArtistComments(artist.id);
      comments = AsyncValue.success(fetchedComments);
    } catch (e) {
      comments = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void addComment(String text) async {
    if (text.isEmpty) return;

    final newComment = Comment(id: 'temp', commentText: text);

    comments = AsyncValue.success([...comments.data ?? [], newComment]);
    notifyListeners();

    try {
      await artistRepository.postComment(artist.id, text);
    } catch (e) {
      comments = AsyncValue.error(e);
      notifyListeners();
    }
  }
}
