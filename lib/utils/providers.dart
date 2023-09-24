import 'package:exercise_finder_app/viewmodels/home_view_model.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(),
  ),
];
