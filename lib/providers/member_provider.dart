import 'package:flutter/material.dart';
import 'package:itc_directory/data/user_data.dart';
import 'package:itc_directory/models/user_model.dart';
import 'package:itc_directory/services/fav_service.dart';

enum DataState { loading, hasData, noData }

class MemberProvider extends ChangeNotifier {
  final FavService _service;

  MemberProvider(this._service) {
    _loadFavorites();
  }

  static const List<String> _intiDivisions = ['Inti', 'Media Informasi'];
  static const List<String> _devDivisions = [
    'Project Management',
    'UI/UX Development',
    'Web Development',
    'Mobile Development',
    'Competitive Programming',
    'Machine Learning',
  ];

  UserModel get chairperson {
    return dummyPengurus.firstWhere((m) => m.position == 'Ketua ITC');
  }

  List<UserModel> get intiMembers {
    return dummyPengurus
        .where((m) => _intiDivisions.contains(m.division))
        .toList();
  }

  Map<String, List<UserModel>> get devMembersByDivision {
    return {
      for (final div in _devDivisions)
        div: dummyPengurus.where((m) => m.division == div).toList(),
    };
  }

  List<String> _favoriteNames = [];
  String _message = "";
  String _selectedDivision = 'Semua';
  bool isFavorite(String name) => _favoriteNames.contains(name);

  String get message => _message;
  String get selectedDivision => _selectedDivision;

  List<UserModel> get favoriteMembers {
    return dummyPengurus.where((m) => _favoriteNames.contains(m.name)).toList();
  }

  List<String> get divisions {
    return ['Semua', ...dummyPengurus.map((m) => m.division).toSet()];
  }

  List<UserModel> get filteredMembers {
    if (_selectedDivision == 'Semua') return dummyPengurus;
    return dummyPengurus.where((m) => m.division == _selectedDivision).toList();
  }

  void setDivision(String division) {
    _selectedDivision = division;
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    _favoriteNames = _service.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(String name) async {
    try {
      if (_favoriteNames.contains(name)) {
        _favoriteNames.remove(name);
        _message = "Dihapus dari favorit";
      } else {
        _favoriteNames.add(name);
        _message = "Ditambahkan ke favorit";
      }
      notifyListeners();
      await _service.saveFavorites(_favoriteNames);
    } catch (e) {
      _message = "Gagal memperbarui favorit";
      notifyListeners();
    }
  }
}
