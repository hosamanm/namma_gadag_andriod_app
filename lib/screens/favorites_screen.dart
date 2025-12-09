import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/favorites_controller.dart';
import '../data/gadag_places_data.dart';
import 'place_detail_screen.dart';
import '../widgets/place_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final favorites = context.watch<FavoritesController>();

    final favoritePlaces = gadagPlaces
        .where((p) => favorites.isFavorite(p.id))
        .toList();

    if (favoritePlaces.isEmpty) {
      return const Center(
        child: Text(
          "No favorites yet ❤️",
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: favoritePlaces.length,
      itemBuilder: (context, index) {

        final place = favoritePlaces[index];

        return PlaceCard(
          place: place,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    PlaceDetailScreen(place: place),
              ),
            );
          },
        );
      },
    );
  }
}
