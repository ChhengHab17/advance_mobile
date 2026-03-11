import 'package:advance_flutter/W8-HW/utils/async_value.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  AsyncValue<List<Song>> _songs = AsyncValue.loading();

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  AsyncValue<List<Song>> get songs => _songs;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    // 1 - Fetch songs
    await loadSong();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;
  Future<void> loadSong() async {
    _songs = AsyncValue.loading();
    notifyListeners();
    try {
      List<Song> songs = await songRepository.fetchSongs();
      _songs = AsyncValue.data(songs);
    } catch (e) {
      _songs = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
