import 'package:advance_flutter/w10/model/songs/song.dart';
import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              song.imageUrl.toString(),
            ),
          ),
          title: Text(song.title),
          subtitle: Row(
            children: [
              Text("${song.duration.inMinutes} mins"),
            ],
          ),
        ),
      ),
    );
  }
}
