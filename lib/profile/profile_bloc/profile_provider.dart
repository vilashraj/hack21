import 'dart:convert';

import 'package:Hackathon/utils/firebase.dart';
import 'package:Hackathon/utils/shared_pref_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../profile_dm.dart';

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

/// <h1>profile_provider</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 1:00 pm
/// 

class ProfileProvider {
  final FirebaseDatabase database = FirebaseUtil.defaultDatabase;

  Future<ProfileDm> getProfileData()async{
    ProfileDm profileDm;
    DatabaseReference ref = database.reference();
    String uID = await SharedPrefUtils().getValue(key: SharedPrefKey.userId);
    if(uID == null || uID.isEmpty){
      return null;
    }
    DataSnapshot snapshot = await ref.child(FirebaseUtil.profileDetail).child(uID).once();
    if(snapshot.value != null){
      profileDm = ProfileDm.fromJson(Map<String, dynamic>.from(snapshot.value));
    }
    return profileDm;
  }

  setProfileData({@required ProfileDm profileDm})async{
    DatabaseReference ref = database.reference();
    String uID = await SharedPrefUtils().getValue(key: SharedPrefKey.userId);
    String email = await SharedPrefUtils().getValue(key: SharedPrefKey.email);
    profileDm.id = uID;
    profileDm.email = email;
    await ref.child(FirebaseUtil.profileDetail).update({
      uID: profileDm.toJson()
    });
  }

}