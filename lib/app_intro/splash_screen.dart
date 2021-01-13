import 'dart:async';

import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_bloc.dart';
import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_event.dart';
import 'package:Hackathon/app_intro/welcome_background.dart';
import 'package:Hackathon/authentication/login/login_background.dart';
import 'package:Hackathon/authentication/sign_up/sign_up_background.dart';
import 'package:Hackathon/utils/on_widget_did_build.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

/// <h1>splash_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:26 pm
/// 




class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final splashDelay = 5;
  AppFlowBloc appFlowBloc;

  AnimationController _controller;
  AnimationController _appNameController;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    _appNameController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _controller.forward();
    _appNameController.forward();
    appFlowBloc = BlocProvider.of<AppFlowBloc>(context);
    onWidgetDidBuild(()async{
      Future.delayed(Duration(seconds: 2)).then((value){
        appFlowBloc.add(WelcomeEvent());
      });

    });

  }


  @override
  void dispose() {
    this._controller.dispose();
    this._appNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WelcomeBackground(
          child: LoginBackground(
            child: SignUpBackground(
              child: Container(

                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ScaleTransition(
                                    scale: Tween(begin: 0.1, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: _controller,
                                            curve: Curves.elasticOut,

                                            reverseCurve: Curves.elasticIn)),
                                    child: Image.asset(
                                        'assets/images/thinking.png',
                                        height: 70,
                                        width: 70,
                                        color: Theme.of(context).primaryColor
                                    )),
                                SizedBox(
                                  height: 15,
                                ),
                                FadeTransition(
                                    opacity: _appNameController,
                                    child: Text(
                                      "Talent Hunt",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )),

                                SizedBox(height: 3,),
                                FadeTransition(
                                    opacity: _appNameController,
                                    child: Text(
                                      "- Vilash Patel",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic,
                                          color: Theme.of(context).accentColor),
                                    )),

                              ],
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "1.0.0",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}