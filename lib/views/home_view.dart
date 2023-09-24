import 'package:exercise_finder_app/viewmodels/home_view_model.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final myViewModel = Provider.of<HomeViewModel>(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      color: Colors.blue,
    ));
  }
}
