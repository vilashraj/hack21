import 'package:Hackathon/authentication/login/login_bloc/login_event.dart';
import 'package:Hackathon/authentication/login/or_divider.dart';
import 'package:Hackathon/authentication/login/social_icon.dart';
import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_bloc.dart';
import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_event.dart';
import 'package:Hackathon/authentication/login/login_background.dart';
import 'package:Hackathon/authentication/login/login_bloc/login_state.dart';
import 'package:Hackathon/components/already_have_an_account_acheck.dart';
import 'package:Hackathon/components/rounded_button.dart';
import 'package:Hackathon/components/rounded_input_field.dart';
import 'package:Hackathon/components/rounded_password_field.dart';
import 'package:Hackathon/utils/on_widget_did_build.dart';
import 'package:Hackathon/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'login_bloc/login_bloc.dart';

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

/// <h1>login_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:49 pm
/// 

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  //keys:
  final _formKey = GlobalKey<FormState>();

  // ignore: close_sinks
  AppFlowBloc appFlowBloc;
  LoginBloc loginBloc;


  //controllers:
  TextEditingController userNameController;
  TextEditingController passwordController;

  //focus node:
  FocusNode userNameFocus;
  FocusNode passwordFocus;

  @override
  void initState() {
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();

    loginBloc = LoginBloc(LoginUninitialized());
    appFlowBloc = BlocProvider.of<AppFlowBloc>(context);
    super.initState();
  }


  @override
  void dispose() {
    userNameFocus.dispose();
    passwordFocus.dispose();
    userNameController.dispose();
    passwordController.dispose();
    loginBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody(){
    Size size = MediaQuery.of(context).size;

    return LoginBackground(child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              controller: userNameController,
              focusNode: userNameFocus,
              validator: Validators.emailValidation,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              validator: Validators.passwordValidation,
              controller: passwordController,
              focusNode: passwordFocus,
              onChanged: (value) {},
            ),
            BlocBuilder(
              cubit: loginBloc,
              builder: (context, LoginState state){
                if(state is LoginLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is LoginSuccess){
                  onWidgetDidBuild((){
                    appFlowBloc.add(DashboardEvent());
                  });
                }
                return  RoundedButton(
                  text: "LOGIN",
                  press: () {
                    if(_formKey.currentState.validate()){
                      loginBloc.add(LoginButtonPressed(userName: userNameController.text.trim(), password: passwordController.text.trim()));
                    }
                  },
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                  appFlowBloc.add(SignUpEvent());
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {
                    loginBloc.add(SocialButtonPressed(socialLogin: SocialLogin.google));
                  },
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {
                    loginBloc.add(SocialButtonPressed(socialLogin: SocialLogin.google));
                  },
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {
                    loginBloc.add(SocialButtonPressed(socialLogin: SocialLogin.google));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
