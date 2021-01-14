import 'package:Hackathon/tournament/tournament_dm.dart';

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

/// <h1>add_tournament_event</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 9:47 pm
/// 

abstract class AddTournamentEvent {}
 class AddTournament extends AddTournamentEvent{
  TournamentDm tournamentDm;
  AddTournament(this.tournamentDm);
 }

 class EmptyEvent extends AddTournamentEvent{
  TournamentDm tournamentDm;
  EmptyEvent(this.tournamentDm);
 }