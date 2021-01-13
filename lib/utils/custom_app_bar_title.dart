import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Meditab Software Inc. CONFIDENTIAL
/// __________________
/// 
///  [2018] Meditab Software Inc.
///  All Rights Reserved.
/// 
/// NOTICE:  All information contained herein is, and remains
/// the property of Meditab Software Inc. and its suppliers,
/// if any.  The intellectual and technical concepts contained
/// herein are proprietary to Meditab Software Incorporated
/// and its suppliers and may be covered by U.S. and Foreign Patents,
/// patents in process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material
/// is strictly forbidden unless prior written permission is obtained
/// from Meditab Software Incorporated.

/// <h1>custom_app_bar_title</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 7:22 pm
/// 

class CustomAppBarTitle extends StatefulWidget{

  final String text;
  bool automaticallyLeading;
  Widget leading;
  Widget trailing;
  Color textColor;
  bool isCenterTitle;
  CustomAppBarTitle(this.text, {this.leading, this.trailing, this.automaticallyLeading = true, this.textColor = Colors.black, this.isCenterTitle = false});

  @override
  _CustomAppBarTitleState createState() => _CustomAppBarTitleState();
}

class _CustomAppBarTitleState extends State<CustomAppBarTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 48.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.leading ?? getBackButton(),
                SizedBox(width: 8.0,),
                Row(
                  children: [
                    Text(
                      widget.text,
                      style: TextStyle(
                          color: widget.textColor,
                          fontSize: 12 *( MediaQuery.of(context).size.longestSide/ MediaQuery.of(context).size.shortestSide),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.trailing ?? Container(),

          ],
        ),
        SizedBox(width: 16.0,),

      ],
    );
  }

  getBackButton(){
    if(!widget.automaticallyLeading){
      return SizedBox(width: 16.0);
    }
    return Navigator.of(context).canPop()?GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: widget.textColor,)):SizedBox(width: 16.0);
  }
}