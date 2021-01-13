import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_bloc.dart';
import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_event.dart';
import 'package:Hackathon/authentication/login/login_background.dart';
import 'package:Hackathon/authentication/sign_up/sign_up_background.dart';
import 'package:Hackathon/authentication/sign_up/sign_up_bloc/sign_up_event.dart';
import 'package:Hackathon/authentication/sign_up/sign_up_bloc/sign_up_state.dart';
import 'package:Hackathon/components/already_have_an_account_acheck.dart';
import 'package:Hackathon/components/rounded_button.dart';
import 'package:Hackathon/components/rounded_input_field.dart';
import 'package:Hackathon/components/rounded_password_field.dart';
import 'package:Hackathon/utils/on_widget_did_build.dart';
import 'package:Hackathon/utils/show_snackbar.dart';
import 'package:Hackathon/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'sign_up_bloc/sign_up_bloc.dart';

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

/// <h1>sign_up_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 3:28 pm
/// 

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  //keys:
  final _formKey = GlobalKey<FormState>();


  AppFlowBloc appFlowBloc;
  SignUpBloc signUpBloc;

  // controllers:

  TextEditingController userNameController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;


  //focus node:

  FocusNode userNameFocus;
  FocusNode passwordFocus;
  FocusNode confirmPasswordFocus;


  @override
  void initState() {
    signUpBloc = SignUpBloc(SignUpUninitialized());
    appFlowBloc = BlocProvider.of<AppFlowBloc>(context);
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userNameFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
    passwordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    userNameFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    signUpBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return getBody();
  }
  Widget getBody(){
    Size size = MediaQuery.of(context).size;
    return SignUpBackground(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),

              RoundedInputField(
                hintText: "Your Email",
                controller: userNameController,
                validator: Validators.emailValidation,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                controller: passwordController,
                validator: Validators.passwordValidation,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                controller: confirmPasswordController,
                validator:(value) => Validators.confirmPasswordValidation(passwordController.text, confirmPasswordController),
                onChanged: (value) {},
              ),
              BlocBuilder(
                cubit: signUpBloc,
                builder: (context, SignUpState state){
                  if(state is SignUpLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(state is SignUpError){
                    onWidgetDidBuild((){
                      showSnackbar(context: context, content: state.error);
                      signUpBloc.add(EmptyEvent());
                    });
                  }
                  else if(state is SignUpSuccess){
                    onWidgetDidBuild((){
                      appFlowBloc.add(ProfileEvent());
                    });
                  }
                  return  RoundedButton(
                    text: "SIGN UP",
                    press: () {
                      if(_formKey.currentState.validate()){
                        signUpBloc.add(SignUpButtonPressed(userName: userNameController.text.trim(), password: passwordController.text.trim()));
                      }
                    },
                  );
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  appFlowBloc.add(LoginEvent());
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
