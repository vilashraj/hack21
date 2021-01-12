import 'package:Hackathon/components/text_field_container.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


// ignore: must_be_immutable
class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  Function validator;
  TextEditingController controller;
  FocusNode focusNode;
   RoundedPasswordField({
    Key key,
    this.onChanged,
     this.validator,
     this.controller,
     this.focusNode
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {


  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: obscure,
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              obscure?Icons.visibility:Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onTap: (){
              setState(() {
                obscure = !obscure;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
