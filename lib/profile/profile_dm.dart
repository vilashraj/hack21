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

/// <h1>profile_dm</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 12:00 pm
/// 

class ProfileDm {
  String id;
  String name;
  String aboutMe;
  String email;
  String photoUrl;
  String status;
  String phone;
  ProfileDm({
    this.id,
    this.name,
    this.email,
    this.aboutMe,
    this.status,
    this.photoUrl,
    this.phone
});

  ProfileDm.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.email = json['email'];
    this.name = json['name'];
    this.aboutMe = json['aboutMe'];
    this.status = json['status'];
    this.phone = json['phone'];
    this.photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['aboutMe'] = this.aboutMe;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}