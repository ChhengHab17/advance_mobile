import 'package:advance_flutter/w9/data/repositories/artists/artist_repository.dart';
import 'package:advance_flutter/w9/ui/screens/artist/view_model/artist_view_model.dart';
import 'package:advance_flutter/w9/ui/screens/artist/widgets/artist_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArtistViewModel(
        artistRepository: context.read<ArtistRepository>()
      ),
      child: ArtistContent(),
    );
  }
}
