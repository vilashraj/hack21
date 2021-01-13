import 'dart:convert';

import 'package:Hackathon/utils/firebase.dart';
import 'package:firebase_database/firebase_database.dart';

import 'domain_dm.dart';

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

/// <h1>domain_provider</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 5:54 pm
/// 

class DomainProvider {
  final FirebaseDatabase database = FirebaseUtil.defaultDatabase;

  Future<List<DomainDm>> fetchDomains()async{
    List<DomainDm> domainList = [];
    DatabaseReference ref = database.reference();
    DataSnapshot snapshot = await ref.child(FirebaseUtil.domains).once();

    if (snapshot != null && snapshot.value != null) {
      for (var value in snapshot.value.values) {
//      speakers.add(SpeakerDm.fromJson(value));
        var valueMap = jsonDecode(jsonEncode(value));
        domainList.add(DomainDm.fromJson((valueMap)));
      }
    }

    return domainList;

  }
}