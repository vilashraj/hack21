import 'package:Hackathon/utils/firebase.dart';
import 'package:Hackathon/utils/shared_pref_utils.dart';
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

/// <h1>add_tournament_provider</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 9:48 pm
/// 

class AddTournamentProvider {
  final FirebaseDatabase database = FirebaseUtil.defaultDatabase;

  Future<TournamentDm> addTournament({@required TournamentDm tournament})async{
    DatabaseReference ref = database.reference();
    String uID = await SharedPrefUtils().getValue(key: SharedPrefKey.userId);
    tournament.createdBy = uID;

    DatabaseReference reference = ref.child(FirebaseUtil.tournaments).push();
    String key = tournament.id ?? reference.key;
    await ref.child(FirebaseUtil.tournaments+"/$key").set(tournament.toJson());
    tournament.id = key;
    return tournament;
  }
}