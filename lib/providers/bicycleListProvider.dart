import 'package:bicycle_renting/models/bicycle.dart';
import 'package:bicycle_renting/services/remoteDataService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class bicycleListProvider with ChangeNotifier {
  bool _loading = false;
  final RemoteDataService _remoteDataService = RemoteDataService();
  bool get loading => _loading;
  String _searchOption = bicycleSearchOption[0];
  String get searchOption => _searchOption;
  String _searchTxt = "";
  String get searchTxt => _searchTxt;
  String _sortOption = bicycleSortOption[0];
  String get orderOption => _sortOption;
  Stream<List<Bicycle>> _bicycles = const Stream.empty();
  Stream<List<Bicycle>> get bicycles => _bicycles;
  List<bool> _selectedAvailability = [false, false];
  List<bool> get selectedAvailability => _selectedAvailability;
  void onSearchOptionChange(String search) {
    _searchOption = search;
    _searchTxt = '';
    _selectedAvailability = [false, false];
    notifyListeners();
  }

  void onAvailabilityClick(int index) {
    _selectedAvailability = [false, false];
    _selectedAvailability[index] = true;
    notifyListeners();
  }

  void onSearchChange(String txt) {
    _searchTxt = txt;
    notifyListeners();
  }

  void onSortOptionChange(String order) {
    _sortOption = order;
    notifyListeners();
  }

  void getbicycles() {
    _bicycles = _remoteDataService.getbicyclesList(_sortOption);
    notifyListeners();
  }
}
