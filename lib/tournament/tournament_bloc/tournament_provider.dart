import 'package:Hackathon/utils/firebase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../tournament_dm.dart';

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

/// <h1>tournament_provider</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/14/21 3:30 am
/// 

class TournamentProvider {
  final FirebaseDatabase database = FirebaseUtil.defaultDatabase;

  Future<List<TournamentDm>> fetchTournaments({@required String domainId}) async{
    DatabaseReference ref = database.reference();
    DataSnapshot snapshot = await ref.child(FirebaseUtil.tournaments).orderByChild("domainId").equalTo(domainId).once();

    if(snapshot.value != null){
      List<TournamentDm> list = [];
      snapshot.value.forEach((k,v){
        list.add(TournamentDm.fromJson(Map<String,dynamic>.from(v)));
      });
      return list;
    }else{
      return [];
    }
  }
}