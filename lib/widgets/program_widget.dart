import 'package:flutter/material.dart';

class ProgramWidget extends StatelessWidget {
  const ProgramWidget({
    Key? key,
    required this.widgetText,
    required this.clickFunction,
  }) : super(key: key);

  final String widgetText;
  final VoidCallback clickFunction;

  @override
  Widget build(BuildContext context) {
    //Color widgetColor = ColorItems.softGreyColor;

    return SizedBox(
      width: 105,
      child: ElevatedButton(
        onPressed: () {
          clickFunction();
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Text(
            widgetText,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
