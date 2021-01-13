import 'package:Hackathon/utils/on_widget_did_build.dart';
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

/// <h1>show_snackbar</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 6:10 pm
/// 
Function showSnackbar({
  @required BuildContext context,
  @required String content,
  Duration duration,
  Color backgroundColor,
  GlobalKey<ScaffoldState> scaffoldKey,
  Function callback,
}) {
  assert(context != null);
  assert(content != null);
  final Duration defaultDuration = duration ?? Duration(milliseconds: 2000);
  final Color defaultColor = backgroundColor ?? Theme.of(context).accentColor;

  onWidgetDidBuild(() {

    if(scaffoldKey != null){

      scaffoldKey.currentState.removeCurrentSnackBar(reason: SnackBarClosedReason.hide);
      scaffoldKey.currentState.showSnackBar( SnackBar(
          content: Text(content),
          duration: defaultDuration,
          backgroundColor: defaultColor),
      );
    }else{
      Scaffold.of(context)
          .removeCurrentSnackBar(reason: SnackBarClosedReason.hide);
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text(content),
            duration: defaultDuration,
            backgroundColor: defaultColor),
      );
    }
    if (callback != null) {
      callback();
    }
  });
}