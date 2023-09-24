import 'package:exercise_finder_app/models/exercise.dart';
import 'package:exercise_finder_app/services/api_service.dart';
import 'package:flutter/material.dart';

enum HomeState { busy, idle, error }

class HomeViewModel with ChangeNotifier {
  HomeState _state = HomeState.idle;
  TextEditingController searchTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<String> muscleList = [
    "Select",
    "Abdominals",
    "Abductors",
    "Adductors",
    "Biceps",
    "Calves",
    "Chest",
    "Forearms",
    "Glutes",
    "Hamstrings",
    "Lats",
    "Lower_back",
    "Neck",
    "Quadriceps",
    "Traps",
    "Triceps"
  ];

  List<String> typeList = [
    "Select",
    "Cardio",
    "Olympic_weightlifting",
    "Plyometrics",
    "Powerlifting",
    "Strength",
    "Stretching",
    "Strongman"
  ];
  int muscleIndex = 0;
  int typeIndex = 0;

  List<Exercise>? exerciseList;

  HomeState get state => _state;

  set state(HomeState state) {
    _state = state;
    notifyListeners();
  }

  HomeViewModel() {
    fetchExercises();
  }

  void onParametersChanged() async {
    await fetchExercises();

    notifyListeners();
  }

  Future<List<Exercise>?> fetchExercises() async {
    try {
      state = HomeState.busy;

      exerciseList =
          await ApiService().fetchExercises(searchTextController.text, typeList[typeIndex], muscleList[muscleIndex]);
      state = HomeState.idle;
      return exerciseList;
    } catch (e) {
      state = HomeState.error;
      return [];
    }
  }

  void changeTypeIndex(int newValue) {
    typeIndex = newValue;

    notifyListeners();
  }

  void changeMuscleIndex(int newValue) {
    muscleIndex = newValue;
    notifyListeners();
  }

  void clearFilters() {
    muscleIndex = 0;
    typeIndex = 0;
    onParametersChanged();
  }
}
