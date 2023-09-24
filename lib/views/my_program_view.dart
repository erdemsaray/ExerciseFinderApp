import 'dart:math';

import 'package:exercise_finder_app/utils/color_constants.dart';
import 'package:exercise_finder_app/utils/string_constants.dart';
import 'package:exercise_finder_app/viewmodels/home_view_model.dart';
import 'package:exercise_finder_app/viewmodels/my_program_view_model.dart';
import 'package:exercise_finder_app/widgets/exercise_card_widget.dart';
import 'package:exercise_finder_app/widgets/program_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MyProgram extends StatelessWidget {
  const MyProgram({super.key});

  @override
  Widget build(BuildContext context) {
    final myViewModel = Provider.of<MyProgramViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context);

    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          expandedHeight: 140,
          collapsedHeight: 100,
          pinned: true,
          backgroundColor: ColorConstants.colorAppBarBackground,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1.2,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(StringConstants.secondPageTitle),
                const SizedBox(
                  height: 17,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                          height: min(33, 100),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: myViewModel.programCount,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: ProgramWidget(
                                  widgetText: "Program ${index + 1}",
                                  clickFunction: () => myViewModel.changeSelectedProgram(index + 1),
                                ),
                              );
                            },
                          ))),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            centerTitle: true,
          ),
        ),
        switch (myViewModel.state) {
          MyProgramState.busy => SliverFillRemaining(
              child: Center(
                child: SizedBox(
                    height: 200,
                    width: 300,
                    child: OverflowBox(
                      maxHeight: 400,
                      maxWidth: 420,
                      child: Lottie.asset(
                        'assets/lotties/athlete.json',
                        fit: BoxFit.fill,

                        //controller: lottieController,
                      ),
                    )),
              ),
            ),
          MyProgramState.idle => SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete,
                              size: size.height * 0.06,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.08,
                            )
                          ],
                        ),
                      ),
                      key: ValueKey<int>(index),
                      onDismissed: (DismissDirection direction) {},
                      dismissThresholds: const {DismissDirection.startToEnd: 2.00, DismissDirection.endToStart: 0.05},
                      child: ExerciseCardWidget(
                        index: index,
                        title: homeViewModel.exerciseList?[index + 2].name,
                        muscle: homeViewModel.exerciseList?[index + 2].muscle,
                        type: homeViewModel.exerciseList?[index + 2].type,
                        isInProgram: true,
                      ));
                },
                childCount: 3,
              ),
            ),
          MyProgramState.error => const SliverFillRemaining(
              child: Center(
                child: Text("Error"),
              ),
            ),
        }
      ],
    ));
  }
}
