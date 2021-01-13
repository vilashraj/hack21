import 'package:Hackathon/profile/profile_bloc/profile_repo.dart';
import 'package:Hackathon/utils/app_singleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../profile_dm.dart';
import 'profile_event.dart';
import 'profile_state.dart';

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

/// <h1>profile_bloc</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 1:00 pm
/// 

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileRepo profileRepo = ProfileRepo();
  ProfileBloc(ProfileState initialState) : super(initialState);

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
   if(event is FetchProfile){
     try{
       yield ProfileLoading();
       ProfileDm profileDm = await profileRepo.getProfileData();
       AppSingleton singleton = AppSingleton();
       singleton.profileDm = profileDm;
       yield ProfileLoaded(profileDm: profileDm);
     }catch(e){
       yield ProfileError(e.toString());
     }
   }
   else if(event is UpdateProfile){
     try{
       yield ProfileSaving();
       await profileRepo.setProfileData(profileDm: event.profileDm);
       AppSingleton singleton = AppSingleton();
       singleton.profileDm = event.profileDm;
       yield ProfileLoaded(profileDm: event.profileDm, isUpdated: true);
     }catch(e){
       yield ProfileSavingError(e.toString());
     }
   }
   else if(event is EmptyEvent){
     yield ProfileLoaded(profileDm: event.profileDm);
   }
  }
}