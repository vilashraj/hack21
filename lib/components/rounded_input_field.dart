import 'package:Hackathon/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


// ignore: must_be_immutable
class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  Function validator;
  TextEditingController controller;
  FocusNode focusNode;
  RoundedInputField({
    Key key,
    this.hintText,
    this.validator,
    this.controller,
    this.focusNode,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        cursorColor: kPrimaryColor,
        focusNode: focusNode,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
