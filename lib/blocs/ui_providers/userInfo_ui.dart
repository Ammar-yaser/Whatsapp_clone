import 'package:flutter/foundation.dart';

class InfoUIState with ChangeNotifier {
  int _nameLength = 30, _aboutLength = 120;

  set nameLength(int val) {
    _nameLength = 30 - val;
    notifyListeners();
  }
  set aboutLength(int val) {
    _aboutLength = 120 - val;
    notifyListeners();
  }

  int get nameLength => _nameLength;
  int get aboutLength => _aboutLength;



}