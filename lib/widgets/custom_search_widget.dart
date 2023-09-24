import 'package:exercise_finder_app/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    Key? key,
    required this.textFormController,
    required this.hintText,
    required this.formIcon,
  }) : super(key: key);

  final TextEditingController textFormController;
  final String hintText;
  final IconData formIcon;
  final IconData? formSuffixIcon = null;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: ColorConstants.colorLabel),
      controller: textFormController,
      autofocus: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.colorBorder,
          ),
        ),
        hoverColor: ColorConstants.colorHover,
        hintText: hintText,
        hintStyle: TextStyle(color: ColorConstants.colorLabel),
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
        ),
        prefixIcon: Icon(
          formSuffixIcon,
          color: ColorConstants.colorIcon,
        ),
      ),
    );
  }
}
