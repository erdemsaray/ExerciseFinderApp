import 'package:exercise_finder_app/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget(
      {Key? key,
      required this.textFormController,
      required this.hintText,
      required this.formIcon,
      required this.onChangedFunction,
      this.focusNode
     })
      : super(key: key);

  final TextEditingController textFormController;
  final String hintText;
  final IconData formIcon;
  final IconData? formSuffixIcon = null;
  final VoidCallback onChangedFunction;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onChangedFunction();
      },
      focusNode: focusNode,
      style: const TextStyle(color: Colors.black, fontSize: 14),
      controller: textFormController,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.colorBorder,
          ),
        ),
        hoverColor: ColorConstants.colorHover,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(formIcon),
          color: ColorConstants.colorIcon,
          iconSize: 16,
        ),
      ),
    );
  }
}
