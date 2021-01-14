import 'dart:async';

import 'package:Hackathon/domains/domain_bloc/domain_dm.dart';
import 'package:Hackathon/tournament/tournament_bloc/tournament_event.dart';
import 'package:Hackathon/tournament/tournament_bloc/tournament_state.dart';
import 'package:Hackathon/tournament/tournament_dm.dart';
import 'package:Hackathon/utils/base_empty_screen.dart';
import 'package:Hackathon/utils/custom_app_bar_title.dart';
import 'package:Hackathon/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'add_tournament.dart';
import 'tournament_bloc/tournament_bloc.dart';

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

/// <h1>tournament_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 3:30 pm
/// 

// ignore: must_be_immutable
class TournamentScreen extends StatefulWidget {
  DomainDm domain;
  TournamentScreen(this.domain);
  @override
  _TournamentScreenState createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> {

  TournamentBloc tournamentBloc;

  Completer<void> _refreshCompleter;


  @override
  void initState() {
    tournamentBloc = TournamentBloc(TournamentUninitialized());
    tournamentBloc.add(FetchTournaments(widget.domain.id));
    _refreshCompleter = Completer<void>();

    super.initState();
  }

  @override
  void dispose() {
    tournamentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(widget.domain.color),
          child: Center(
            child: Icon(Icons.add),
          ),
          onPressed: ()async{
            await Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddTournamentScreen(widget.domain)));
            tournamentBloc.add(RefreshTournaments(widget.domain.id));
          },
        ),
    );
  }

  Widget getBody() {
    return Column(
      children: [
        Hero(
          tag: widget.domain.id,
          child: Material(
            child: Container(
              color: Color(widget.domain.color),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CustomAppBarTitle(
                  widget.domain.name,
                  textColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder(
              cubit: tournamentBloc,
              builder: (context, TournamentState state){
                if(state is TournamentUninitialized || state is TournamentLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is TournamentLoaded){
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                  if(state.tournamentList?.isEmpty ?? true){
                    return EmptyScreen(icon: Icons.tour, title: "No tournaments available");
                  }
                  return tournamentList(state.tournamentList);
                }
                else if(state is TournamentError){

                }
            return Container();
          }),
        )
      ],
    );
  }

  Widget tournamentList(List<TournamentDm> tournaments){
    return RefreshIndicator(
      onRefresh: (){
        tournamentBloc.add(RefreshTournaments(widget.domain.id));
        return _refreshCompleter.future;
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
          itemCount: tournaments.length,
          itemBuilder: (context, int position){
            return tournamentCard(tournaments[position]);
      }),
    );

  }
  Widget tournamentCard(TournamentDm tournament){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:4.0),
      child: Card(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getDateAndTime(tournament.rounds.first.startDate),
                  SizedBox(width: 12.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tournament.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      SizedBox(height: 2.0,),
                      Text(tournament.description),
                      SizedBox(height: 2.0,),

                      Row(
                        children: [
                          Text("${tournament.rounds.first.participants?.length ?? 0}",style: TextStyle(color: Color(widget.domain.color)),),
                          Text("/${tournament.rounds.first.maxTeam} Teams participated",style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
            linearIndicator(value: getValue(startDate: getDateStringToFormat(tournament.rounds.first.startDate), endDate: getDateStringToFormat(tournament.rounds.last.endDate)))

          ],
        ),
      ),
    );
  }

  double getValue({@required DateTime startDate, @required DateTime endDate}){
    if(DateTime.now().isBefore(startDate)) return 0.0;
    else if(DateTime.now().isAfter(endDate)) return 1.0;
    else{
      double value = ((DateTime.now().millisecondsSinceEpoch)-(startDate.millisecondsSinceEpoch))/((endDate.millisecondsSinceEpoch)-(startDate.millisecondsSinceEpoch));
      return value;
    }
  }
  Widget getDateAndTime(String date){
    DateTime dt = getDateStringToFormat(date);
    return Column(
      children: <Widget>[
        Text(DateFormat.MMM().format(dt),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0)),
        SizedBox(height:2.0),
        Text(dt.day.toString().padLeft(2,"0"),style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18.0),),
        SizedBox(height:2.0),
        Text(dt.year.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0),),
        SizedBox(height:2.0),
        Text(DateFormat("hh:mm a").format(dt),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.0)),
      ],
    );
  }
  DateTime getDateStringToFormat(String date){
    DateTime dt = DateFormat(FirebaseUtil.dateFormat).parse(date);
    return dt;
  }
  Widget linearIndicator({double value = 0.5}){
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth * value,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Color(widget.domain.color),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                    ),
                  );
                }
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: Container(
        //     height: 5,
        //     color: Colors.transparent,
        //   ),
        // ),
      ],
    );
  }


}
