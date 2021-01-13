import 'package:Hackathon/profile/profile_bloc/profile_bloc.dart';
import 'package:Hackathon/profile/profile_bloc/profile_event.dart';
import 'package:Hackathon/profile/profile_bloc/profile_state.dart';
import 'package:Hackathon/profile/profile_dm.dart';
import 'package:Hackathon/utils/base_empty_screen.dart';
import 'package:Hackathon/utils/custom_app_bar_title.dart';
import 'package:Hackathon/utils/on_widget_did_build.dart';
import 'package:Hackathon/utils/show_snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

/// <h1>profile_ui</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 7:15 pm
/// 

class ProfileUi extends StatefulWidget {
  bool newlyCreatedProfile;
  ProfileUi({this.newlyCreatedProfile = false});
  @override
  _ProfileUiState createState() => _ProfileUiState();
}

class _ProfileUiState extends State<ProfileUi> {

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController statusController;
  TextEditingController aboutController;


  bool isEditing;

  String profilePicUrl = "";
String email = "";

  ProfileBloc profileBloc;
  @override
  void initState() {

    isEditing = widget.newlyCreatedProfile;
    nameController = TextEditingController();
    phoneController = TextEditingController();
    statusController = TextEditingController();
    aboutController = TextEditingController();

    profileBloc = ProfileBloc(ProfileUninitialized());
    profileBloc.add(FetchProfile());
    super.initState();
  }

  @override
  void dispose() {
    profileBloc.close();
    nameController.dispose();
    phoneController.dispose();
    statusController.dispose();
    aboutController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CustomAppBarTitle(
              "My Profile",
            leading: Navigator.of(context).canPop()?GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back)):Container(),
            trailing: BlocBuilder(
              cubit: profileBloc,
              builder: (context, ProfileState state) {
                if(state is ProfileLoaded){
                  return GestureDetector(
                      onTap: (){
                        if(isEditing){
                          profileBloc.add(UpdateProfile(getProfileData()));
                        }
                        setState(() {
                          isEditing = !isEditing;
                        });

                      },
                      child: Icon(isEditing?Icons.done:Icons.edit));
                }
                else if(state is ProfileSaving){
                  return Center(child: CircularProgressIndicator(),);
                }

                else if(state is ProfileSavingError){
                  onWidgetDidBuild((){
                    showSnackbar(context: context, content: "Failed to set profile details.");
                    profileBloc.add(EmptyEvent(getProfileData()));
                  });

                }
                return Container();
              }
            ),
          ),
          BlocBuilder(
            cubit: profileBloc,
            builder: (context, ProfileState state) {
              if(state is ProfileLoading){
                return Expanded(child: Center(child: CircularProgressIndicator()));
              }
              else if (state is ProfileLoaded && state.profileDm != null){
                  nameController.text = state.profileDm.name;
                  statusController.text = state.profileDm.status;
                  aboutController.text = state.profileDm.aboutMe;
                  phoneController.text = state.profileDm.phone;
                  profilePicUrl = state.profileDm.photoUrl;
                  email = state.profileDm.email;
              }
              else if(state is ProfileError){
                return EmptyScreen.error(title: "Failed to fetch profile details", onClick: (){
                  profileBloc.add(FetchProfile());
                });
              }
              return profileBody();
            }
          ),
        ],
      ),
    );
  }

  Widget profileBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          imageCard(),
          referCard(),
          phoneField(),
          aboutField(),
        ],

      ),
    );
  }
  Widget imageCard(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("assets/images/profile_background.jpg",
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: (profilePicUrl?.isNotEmpty ?? false)?  CachedNetworkImageProvider(profilePicUrl ?? "") : null,
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: MediaQuery.of(context).size.width * 0.155,
                          child: (profilePicUrl?.isNotEmpty ?? false)?Container():Center(child: Icon(Icons.person, size: MediaQuery.of(context).size.width * 0.275,color: Colors.white,)),
                        ),
                        isEditing?
                        Positioned(
                          bottom: 6.0,
                          right: 8.0,
                          child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(Icons.edit, color: Colors.white, size: 20,),
                              )),
                        ):Container()
                      ],
                    ),

                  ],
                ),
              ),
              isEditing? nameTextField():Text(nameController.text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(email, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 12.0),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: isEditing? statusTextField():Text(statusController.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.3),
                      fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget referCard(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(128, 42, 217, 1.0),
                Color.fromRGBO(95, 33, 157, 1.0)
              ]
            )
          ),
          child: ListTile(
            leading: Icon(Icons.card_giftcard_rounded, color: Colors.white,size: 30,),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
            title: Text("Invite friends & earn free rewards", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
          ),
        ),
      ),
    );
  }

  Widget phoneField(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 7.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(128, 42, 217, 1.0),
                      Color.fromRGBO(95, 33, 157, 1.0)
                    ]
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.call, color: Colors.white,),
            ),
          ),
          title: isEditing?phoneTextField():Text(phoneController.text),
        ),
      ),
    );
  }
  Widget aboutField(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: Colors.white,
        elevation: 7.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: ExpansionTile(

          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(128, 42, 217, 1.0),
                      Color.fromRGBO(95, 33, 157, 1.0)
                    ]
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.person, color: Colors.white,),
            ),
          ),

          title: Text("About me"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isEditing? aboutTextField():Text(aboutController.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneTextField(){
    return TextFormField(
      controller: phoneController,
      decoration: InputDecoration.collapsed(hintText: "Phone",),
    );
  }


  Widget nameTextField(){
    return Center(
      child: TextFormField(
        controller: nameController,
        textAlign: TextAlign.center,
        decoration: InputDecoration.collapsed(hintText: "Name",),
      ),
    );
  }
  Widget statusTextField(){
    return Center(
      child: TextFormField(
        maxLines: 3,
        minLines: 1,
        controller: statusController,
        textAlign: TextAlign.center,
        decoration: InputDecoration.collapsed(hintText: "Status",),
      ),
    );
  }
  Widget aboutTextField(){
    return Center(
      child: TextFormField(
        controller: aboutController,
        textAlign: TextAlign.center,
        maxLines: 3,
        decoration: InputDecoration.collapsed(hintText: "Just pen down about yourself",),
      ),
    );
  }

  ProfileDm getProfileData(){
    return ProfileDm(
      aboutMe: aboutController.text,
      phone: phoneController.text,
      name: nameController.text,
      status: statusController.text,
    );
  }
}
