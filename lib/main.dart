import 'package:exercise_finder_app/utils/providers.dart';
import 'package:exercise_finder_app/utils/string_constants.dart';
import 'package:exercise_finder_app/views/tabbar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: providers,
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //I generally create another class for my providers.
  // Because multiple providers class increase complexity.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      home: const TabbarView(),
    );
  }
}
