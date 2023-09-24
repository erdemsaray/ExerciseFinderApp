import 'package:exercise_finder_app/viewmodels/home_view_model.dart';
import 'package:exercise_finder_app/viewmodels/my_program_view_model.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(),
  ),
  ChangeNotifierProvider<MyProgramViewModel>(
    create: (context) => MyProgramViewModel(),
  ),
];
