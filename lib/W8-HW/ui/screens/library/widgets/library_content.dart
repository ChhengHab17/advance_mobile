import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    // 1- Read the globbal song repository
    LibraryViewModel mv = context.watch<LibraryViewModel>();
    if (mv.songs.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (mv.songs.error != null) {
      return Center(child: Text("Error: ${mv.songs.error}", style: TextStyle(color: Colors.red),));
    }
    final songs = mv.songs.data!;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          SizedBox(height: 50),
      
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => SongTile(
                song: songs[index],
                isPlaying: mv.isSongPlaying(songs[index]) ,
                onTap: () {
                  mv.start(songs[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
