import 'package:Hackathon/tournament/add_tournament_bloc/add_tournament_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../tournament_dm.dart';
import 'add_tournament_event.dart';
import 'add_tournament_state.dart';

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

/// <h1>add_tournament_bloc</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 9:47 pm
/// 

class AddTournamentBloc extends Bloc<AddTournamentEvent,AddTournamentState>{
  AddTournamentBloc(AddTournamentState initialState) : super(initialState);

  AddTournamentRepo addTournamentRepo = AddTournamentRepo();
  @override
  Stream<AddTournamentState> mapEventToState(AddTournamentEvent event) async*{
    if(event is AddTournament){
      try{
        yield AddTournamentSaving();
        TournamentDm obj = await addTournamentRepo.addTournament(tournament: event.tournamentDm);

        yield AddTournamentLoaded(obj);
      }catch(e){
        yield AddTournamentError(e.toString());
      }
    }
    else if(event is EmptyEvent){
      yield AddTournamentLoaded(event.tournamentDm);
    }

  }

}