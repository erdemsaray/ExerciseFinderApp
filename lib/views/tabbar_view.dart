import 'package:exercise_finder_app/utils/color_constants.dart';
import 'package:exercise_finder_app/utils/image_constants.dart';
import 'package:exercise_finder_app/utils/string_constants.dart';
import 'package:exercise_finder_app/views/home_view.dart';
import 'package:exercise_finder_app/views/my_program_view.dart';
import 'package:flutter/material.dart';

class TabbarView extends StatefulWidget {
  const TabbarView({super.key});

  @override
  State<TabbarView> createState() => _TabbarViewState();
}

class _TabbarViewState extends State<TabbarView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab
            ? FloatingActionButton(
                backgroundColor: Colors.transparent,
                child: Image(image: ImageConstants.tabbarImage),
                onPressed: () {
                  if (_tabController.index == 1) {
                    _tabController.animateTo(0);
                  } else {
                    _tabController.animateTo(1);
                  }
                },
              )
            : null,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          shape: const CircularNotchedRectangle(),
          child: TabBar(
            indicatorColor: ColorConstants.colorSplash,
            labelColor: ColorConstants.colorNavigationText,
            controller: _tabController,
            tabs: [
              Tab(
                text: StringConstants.firstPageTitle,
              ),
              Tab(text: StringConstants.secondPageTitle)
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [Home(), MyProgram()],
        ),
      ),
    );
  }
}
