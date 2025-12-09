import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends ChangeNotifier {

  /// ✅ Stores favorite place IDs
  final Set<String> _favorites = {};

  Set<String> get favorites => _favorites;

  /// ✅ Check if a place is favorite
  bool isFavorite(String placeId) =>
      _favorites.contains(placeId);

  /// ✅ Toggle favorite state
  void toggleFavorite(String placeId) {
    if (_favorites.contains(placeId)) {
      _favorites.remove(placeId);
    } else {
      _favorites.add(placeId);
    }

    _saveToLocal();
    notifyListeners();
  }

  /// ✅ Load saved favorites on app start
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList("favorites") ?? [];
    _favorites.addAll(list);
    notifyListeners();
  }

  /// ✅ Persist favorites locally
  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("favorites", _favorites.toList());
  }
}
