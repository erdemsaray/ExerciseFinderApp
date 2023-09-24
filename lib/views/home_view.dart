import 'package:exercise_finder_app/utils/color_constants.dart';
import 'package:exercise_finder_app/utils/string_constants.dart';
import 'package:exercise_finder_app/viewmodels/home_view_model.dart';
import 'package:exercise_finder_app/widgets/custom_search_widget.dart';
import 'package:exercise_finder_app/widgets/exercise_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final myViewModel = Provider.of<HomeViewModel>(context);
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
                Text(StringConstants.firstPageTitle),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.67,
                          height: 40,
                          child: CustomSearchWidget(
                            textFormController: myViewModel.searchTextController,
                            hintText: "Search",
                            formIcon: Icons.search,
                            focusNode: myViewModel.focusNode,
                            onChangedFunction: myViewModel.onParametersChanged,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FilterDialog(myViewModel: myViewModel);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),
        ),
        switch (myViewModel.state) {
          HomeState.busy => SliverFillRemaining(
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
          HomeState.idle => SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ExerciseCardWidget(
                    index: index,
                    title: myViewModel.exerciseList?[index].name,
                    muscle: myViewModel.exerciseList?[index].muscle,
                    type: myViewModel.exerciseList?[index].type,
                  );
                },
                childCount: myViewModel.exerciseList?.length,
              ),
            ),
          HomeState.error => const SliverFillRemaining(
              child: Center(
                child: Text("Error"),
              ),
            ),
        }
      ],
    ));
  }
}

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    super.key,
    required this.myViewModel,
  });

  final HomeViewModel myViewModel;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    final myViewModel = Provider.of<HomeViewModel>(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Filters"),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            DropdownButton<String>(
              value: widget.myViewModel.typeList[widget.myViewModel.typeIndex],
              isExpanded: true,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              underline: Container(
                height: 0,
                color: ColorConstants.colorBorder,
              ),
              onChanged: (String? newValue) {
                widget.myViewModel.changeTypeIndex(widget.myViewModel.typeList.indexOf(newValue!));
                if (mounted) {
                  setState(() {});
                }
              },
              items: widget.myViewModel.typeList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  "Muscle",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            DropdownButton<String>(
              value: widget.myViewModel.muscleList[widget.myViewModel.muscleIndex],
              isExpanded: true,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              underline: Container(
                height: 0,
                color: Colors.grey,
              ),
              onChanged: (String? newValue) {
                widget.myViewModel.changeMuscleIndex(widget.myViewModel.muscleList.indexOf(newValue!));
                if (mounted) {
                  setState(() {});
                }
              },
              items: widget.myViewModel.muscleList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.colorAppBarBackground),
            onPressed: () {
              myViewModel.clearFilters();
              Navigator.pop(context);
            },
            child: const Icon(Icons.clear)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.colorAppBarBackground),
          onPressed: () {
            myViewModel.onParametersChanged();
            Navigator.pop(context);
          },
          child: const Text("Okay"),
        ),
      ],
    );
  }
}
