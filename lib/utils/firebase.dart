import 'package:firebase_database/firebase_database.dart';

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

/// <h1>firebase</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 12:53 pm
/// 

class FirebaseUtil {

  static FirebaseDatabase defaultDatabase = FirebaseDatabase(
      databaseURL: 'https://hackathon21-ad3a9-default-rtdb.firebaseio.com/');

  static const String dateFormat = "dd MMM, yyyy - HH:mm a";
  static const String profileDetail = "profileDetail";
  static const String domains = "domains";
  static const String tournaments = "tournaments";
}