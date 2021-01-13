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

/// <h1>profile_state</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 1:00 pm
/// 

abstract class ProfileState {}
class ProfileUninitialized extends ProfileState{}
class ProfileLoading extends ProfileState{}
class ProfileLoaded extends ProfileState{
  ProfileDm profileDm;
  bool isUpdated;
  ProfileLoaded({this.profileDm, this.isUpdated = false});
}
class ProfileSaving extends ProfileState{}
class ProfileError extends ProfileState{
  String error;
  ProfileError(this.error);
}class ProfileSavingError extends ProfileState{
  String error;
  ProfileSavingError(this.error);
}