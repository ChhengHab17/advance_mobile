import 'package:advance_flutter/w10/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:advance_flutter/w10/ui/screens/artist/widget/comment_tile.dart';
import 'package:advance_flutter/w10/widget/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistContent extends StatefulWidget {
  const ArtistContent({super.key});

  @override
  State<ArtistContent> createState() => _ArtistContentState();
}

class _ArtistContentState extends State<ArtistContent> {
  final commentController = TextEditingController();

  @override
  void dispose(){
    commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ArtistViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text(vm.artist.name)),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          8,
          16,
          MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                if (commentController.text.isEmpty) {
                  return;
                }
                vm.addComment(commentController.text);
                commentController.clear();
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Songs Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Songs',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            _buildSongs(vm),

            // Comments Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Comments',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            _buildComments(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildSongs(ArtistViewModel vm) {
    if (vm.songs.data == null || vm.songs.data!.isEmpty) {
      return Center(child: Text('No songs yet'));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: vm.songs.data!.length,
      itemBuilder: (context, index) => SongTile(song: vm.songs.data![index]),
    );
  }

  Widget _buildComments(ArtistViewModel vm) {
    if (vm.comments.data == null || vm.comments.data!.isEmpty) {
      return Center(child: Text('No comments yet'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: vm.comments.data!.length,
      itemBuilder: (context, index) =>
          CommentTile(comment: vm.comments.data![index]),
    );
  }
}
