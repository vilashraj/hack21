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

/// <h1>base_empty_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 1:42 pm
/// 

class EmptyScreen extends StatefulWidget {
  IconData icon;
  String title;
  Function onClick;


  EmptyScreen({@required  this.icon, @required this.title});

  EmptyScreen.error({@required this.title,@required this.onClick,this.icon=Icons.error_outline});


  @override
  _EmptyScreenState createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child:widget.onClick==null?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(widget.icon, size: constraints.maxWidth * 0.2, color: Colors.black38),
                ),
                Text(widget.title,textAlign: TextAlign.center,)
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(widget.icon, size: constraints.maxWidth * 0.2, color: Colors.red),
                ),
                Text(widget.title,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(color: Colors.black,icon: Icon(Icons.refresh),onPressed: widget.onClick,),
                )
              ],
            ),
          );
        }
    );
  }
}