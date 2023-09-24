import 'package:exercise_finder_app/models/exercise.dart';
import 'package:flutter/material.dart';

enum MyProgramState { busy, idle, error }

class MyProgramViewModel with ChangeNotifier {
  MyProgramState _state = MyProgramState.idle;
  List<String> programList = ["Program 1", "Program 2", "Program 3"];
  int programIndex = 0;
  int programCount = 3;
  int selectedProgram = 1;

  MyProgramState get state => _state;

  set state(MyProgramState state) {
    _state = state;
    notifyListeners();
  }



  void changeSelectedProgram(int newValue) {
    selectedProgram = newValue;

    notifyListeners();
  }

  void changeProgramIndex(int newValue) {
    programIndex = newValue;
    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    //time is over...
  }
}
