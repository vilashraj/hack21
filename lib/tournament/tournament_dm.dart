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

/// <h1>tournament_dm</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 9:48 pm
/// 

class TournamentDm {
  String id;
  String createdBy;
  String name;
  String domainId;
  String description;
  String perTeamMember;
  List<Rounds> rounds;

  TournamentDm(
      {this.createdBy,
        this.id,
        this.name,
        this.domainId,
        this.description,
        this.perTeamMember,
        this.rounds});

  TournamentDm.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    id = json['id'];
    name = json['name'];
    domainId = json['domainId'];
    description = json['description'];
    perTeamMember = json['perTeamMember'];
    if (json['rounds'] != null) {
      rounds = new List<Rounds>();
      json['rounds'].forEach((v) {
        rounds.add(new Rounds.fromJson(Map<String,dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['domainId'] = this.domainId;
    data['perTeamMember'] = this.perTeamMember;
    if (this.rounds != null) {
      data['rounds'] = this.rounds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rounds {
  String name;
  String index;
  String startDate;
  String endDate;
  String roundDescription;
  String maxTeam;
  List<Participants> participants;

  Rounds(
      {this.name,
        this.index,
        this.startDate,
        this.endDate,
        this.roundDescription,
        this.maxTeam,
        this.participants});

  Rounds.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    index = json['index'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    roundDescription = json['roundDescription'];
    maxTeam = json['maxTeam'];
    if (json['participants'] != null) {
      participants = new List<Participants>();
      json['participants'].forEach((v) {
        participants.add(new Participants.fromJson(Map<String,dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['index'] = this.index;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['roundDescription'] = this.roundDescription;
    data['maxTeam'] = this.maxTeam;
    if (this.participants != null) {
      data['participants'] = this.participants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Participants {
  String id;
  String rank;

  Participants({this.id, this.rank});

  Participants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rank'] = this.rank;
    return data;
  }
}

