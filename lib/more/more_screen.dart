import 'package:Hackathon/profile/profile_ui.dart';
import 'package:Hackathon/utils/app_singleton.dart';
import 'package:Hackathon/utils/custom_app_bar_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

/// <h1>more_screen</h1>
///
/// <p>
///
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 3:22 pm
///

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  AppSingleton singleton;
  bool notification = true;
  @override
  void initState() {
    singleton = AppSingleton();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  Widget getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        CustomAppBarTitle(
          "Settings",
        ),
        SizedBox(height: 8.0,),
        nameTile(),
        myProfileTile(),
        myTournamentsTile(),
        myRewardsTile(),
        myTeamsTile(),
        notificationTile(),
        logoutTile(),
      ],
    );
  }

Widget getDivider(){
    return Padding(
      padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.2,right: 12.0),
      child: Container(
        width: double.infinity,
        color: Colors.grey,
        height: 0.1,
      ),
    );
}

  Widget nameTile(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: MediaQuery.of(context).size.width * 0.1,

            backgroundImage: CachedNetworkImageProvider( "https://picsum.photos/200",),
          ),
          SizedBox(width: 8.0,),
          Expanded(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(singleton.profileDm.name ?? "", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),),
                SizedBox(height: 2.0,),
                Text(singleton.profileDm.status ?? "", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12), )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget myProfileTile(){
      return baseSettingTile(

          icon: Icons.person, title: "My Profile", onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileUi()));
      });
  }
  Widget myTournamentsTile(){
      return baseSettingTile(

          icon: Icons.tour_outlined, title: "My Tournaments", onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileUi()));
      });
  }
  Widget myRewardsTile(){
      return baseSettingTile(

          icon: Icons.card_giftcard_rounded, title: "My Rewards", onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileUi()));
      });
  }
  Widget myTeamsTile(){
      return baseSettingTile(

          icon: Icons.group, title: "My Teams", onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileUi()));
      });
  }
  Widget notificationTile(){
    return baseSettingTile(
      icon: Icons.notifications,
      title: "Notifications",
      trailing: Switch.adaptive(
          activeColor: Theme.of(context).accentColor,
          value: notification, onChanged: (value){
        setState(() {
          notification = value;
        });
      })
    );
  }
  Widget logoutTile(){
      return baseSettingTile(
          trailing: Container(width: 0,),
          icon: Icons.exit_to_app_rounded, title: "Sign Out", onTap: (){

      });
  }
  Widget baseSettingTile({IconData icon, String title, Widget trailing, Function onTap}){
    return Column(
      children: [
        ListTile(
          leading:  Icon(icon, color: Theme.of(context).primaryColor,),
          title: Text(title),
          trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 15,),
          onTap: onTap,
        ),
        getDivider()
      ],
    );
  }
}
