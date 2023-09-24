import 'package:exercise_finder_app/utils/color_constants.dart';
import 'package:exercise_finder_app/viewmodels/my_program_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseCardWidget extends StatelessWidget {
  const ExerciseCardWidget({
    Key? key,
    required this.index,
    required this.title,
    required this.type,
    required this.muscle,
    this.isInProgram = false,
  }) : super(key: key);

  final int index;
  final String? title;
  final String? type;
  final bool isInProgram;

  final String? muscle;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              SizedBox(
                height: 3,
              ),
              Divider(
                thickness: 3,
                color: Colors.grey,
              ),
              SizedBox(
                height: 3,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.colorExerciseCardBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.63,
                          child: Text(
                            title ?? "",
                            maxLines: 1,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AddProgramDialog();
                              },
                            );
                          },
                          icon: Visibility(
                            visible: !isInProgram,
                            child: const Icon(
                              Icons.add_box_outlined,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Type: $type",
                      maxLines: 1,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      muscle ?? "",
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddProgramDialog extends StatefulWidget {
  const AddProgramDialog({
    super.key,
  });

  @override
  State<AddProgramDialog> createState() => _AddProgramDialogState();
}

class _AddProgramDialogState extends State<AddProgramDialog> {
  @override
  Widget build(BuildContext context) {
    final myViewModel = Provider.of<MyProgramViewModel>(context);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Add to Program"),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  "Select",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            DropdownButton<String>(
              value: myViewModel.programList[myViewModel.programIndex],
              isExpanded: true,
              elevation: 16,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              underline: Container(
                height: 0,
                color: ColorConstants.colorBorder,
              ),
              onChanged: (String? newValue) {
                myViewModel.changeProgramIndex(myViewModel.programList.indexOf(newValue!));
                if (mounted) {
                  setState(() {});
                }
              },
              items: myViewModel.programList.map<DropdownMenuItem<String>>((String value) {
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
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
