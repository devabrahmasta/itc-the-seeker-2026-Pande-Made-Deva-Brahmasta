import 'package:shared_preferences/shared_preferences.dart';

class FavService {
  final SharedPreferences _preferences;

  FavService(this._preferences);

  static const String _favKey = "FAVORITE_MEMBERS";

  Future<void> saveFavorites(List<String> favoriteNames) async {
    await _preferences.setStringList(_favKey, favoriteNames);
  }

  List<String> getFavorites() {
    return _preferences.getStringList(_favKey) ?? [];
  }
}
