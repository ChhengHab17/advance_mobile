import 'package:advance_flutter/w9/model/songs/song_with_artist.dart';
import 'package:flutter/material.dart';

import '../../../model/songs/song.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.songWithArtist,
    required this.isPlaying,
    required this.onTap,
  });

  final SongWithArtist songWithArtist;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(backgroundImage: NetworkImage(songWithArtist.song.imageUrl.toString())),
          title: Text(songWithArtist.song.title),
          subtitle: Row(
            children: [
              Text("${songWithArtist.song.duration.inMinutes} mins"),
              SizedBox(width: 8,),
              Text("${songWithArtist.artist.name} - ${songWithArtist.artist.genre}")
            ],
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
