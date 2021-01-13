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

/// <h1>domain_dm</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 5:55 pm
/// 

class DomainDm {

  String name;
  String tagLine;
  String id;
  String image;
  int color;

  DomainDm(
      this.image,
      this.id,
      this.tagLine,
      this.color,
      this.name,
      );

  DomainDm.fromJson(Map<String, dynamic> json){
    this.name = json["name"];
    this.image = json["image"];
    this.tagLine = json["tagLine"];
    this.id = json["id"];
    this.color = int.parse(json["color"]);
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
    data["name"] = this.name;
    data["image"] = this.image;
    data["tagLine"] = this.tagLine;
    data["id"] = this.id;
    data['color'] = this.color;
    return data;
  }
}