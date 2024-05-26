import 'package:bicycle_renting/models/bicycle.dart';
import 'package:bicycle_renting/services/remoteDataService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class bicycleDetailsProvider with ChangeNotifier {
  bool _loading = false;
  final RemoteDataService _remoteDataService = RemoteDataService();
  bool get loading => _loading;
  List<bool> _selectedAvailability = [true, false];
  List<bool> get selectedAvailability => _selectedAvailability;

  String onAvailabilityClick(int index) {
    _selectedAvailability = [false, false];
    _selectedAvailability[index] = true;
    notifyListeners();
    return availability[index];
  }

  void initAvailability() {
    _selectedAvailability = [true, false];
    notifyListeners();
  }

  Future<void> addOrUpdatebicycle(Bicycle bicycle) async {
    _loading = true;
    notifyListeners();
    if (bicycle.id != null) {
      await _remoteDataService.update(bicycle);
    } else {
      await _remoteDataService.addbicycle(bicycle);
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> deletebicycle(Bicycle bicycle) async {
    await _remoteDataService.delete(bicycle);
  }
}
