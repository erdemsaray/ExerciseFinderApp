import 'package:flutter/material.dart';

enum HomeState { busy, idle, error }

class HomeViewModel with ChangeNotifier {
  HomeState _state = HomeState.idle;
  TextEditingController searchTextController = TextEditingController();

  HomeState get state => _state;

  set state(HomeState state) {
    _state = state;
    notifyListeners();
  }
}
