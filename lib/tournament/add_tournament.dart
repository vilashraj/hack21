import 'package:Hackathon/domains/domain_bloc/domain_dm.dart';
import 'package:Hackathon/tournament/add_tournament_bloc/add_tournament_state.dart';
import 'package:Hackathon/tournament/tournament_dm.dart';
import 'package:Hackathon/utils/custom_app_bar_title.dart';
import 'package:Hackathon/utils/firebase.dart';
import 'package:Hackathon/utils/on_widget_did_build.dart';
import 'package:Hackathon/utils/show_snackbar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'add_tournament_bloc/add_tournament_bloc.dart';
import 'add_tournament_bloc/add_tournament_event.dart';

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

/// <h1>add_tournament</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 9:45 pm
/// 

// ignore: must_be_immutable
class AddTournamentScreen extends StatefulWidget {
  DomainDm domainDm;
  TournamentDm tournamentDm;
  AddTournamentScreen(this.domainDm, {this.tournamentDm});
  @override
  _AddTournamentScreenState createState() => _AddTournamentScreenState();
}

class _AddTournamentScreenState extends State<AddTournamentScreen> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController;
  TextEditingController descriptionController;
  TextEditingController perTeamMemberController;

  FocusNode nameFocusNode;
  FocusNode descriptionFocusNode;
  FocusNode perTeamMemberFocusNode;

  List<RoundUiDm> roundList = [];

  AddTournamentBloc addTournamentBloc;

  @override
  void initState() {
    if(widget.tournamentDm != null){
      nameController = TextEditingController(text: widget.tournamentDm.name);
      descriptionController = TextEditingController(text: widget.tournamentDm.description);
      perTeamMemberController = TextEditingController(text: widget.tournamentDm.perTeamMember);
      if(widget.tournamentDm.rounds?.isNotEmpty ?? false){
        for(int i=0; i< widget.tournamentDm.rounds.length; i++){
          roundList.add(RoundUiDm(i+1,participants: widget.tournamentDm.rounds[i].participants ?? []));
        }
      }
    }else{
      roundList = [RoundUiDm(1,participants: [])];
      nameController = TextEditingController();
      descriptionController = TextEditingController();
      perTeamMemberController = TextEditingController();
    }


    nameFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    perTeamMemberFocusNode = FocusNode();

    addTournamentBloc = AddTournamentBloc(AddTournamentUninitialized());

    super.initState();
  }

  @override
  void dispose() {

    addTournamentBloc.close();

    nameController.dispose();
    descriptionController.dispose();
    perTeamMemberController.dispose();

    nameFocusNode.dispose();
    descriptionFocusNode.dispose();
    perTeamMemberFocusNode.dispose();

    roundList.forEach((element){
      element.startController.dispose();
      element.endController.dispose();
      element.roundNameController.dispose();
      element.roundDescriptionController.dispose();
      element.roundNameFocus.dispose();
      element.roundDescriptionFocus.dispose();
      element.maxTeamFocus.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody());
  }

  Widget getBody(){
    return Column(
      children: [
        CustomAppBarTitle("Add Tournament",
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder(
              cubit: addTournamentBloc,
              builder: (context, AddTournamentState state) {
                if(state is AddTournamentSaving){
                  return Center(child: CircularProgressIndicator());
                }
                else if(state is AddTournamentLoaded){
                  widget.tournamentDm = state.tournamentDm;
                }
                else if(state is AddTournamentError){
                  onWidgetDidBuild((){
                    showSnackbar(context: context, content: state.error);
                    addTournamentBloc.add(EmptyEvent(getTournament()));
                  });
                }
                return GestureDetector(
                  onTap: (){
                    addTournamentBloc.add(AddTournament(getTournament()));
                  },
                  child: Icon(Icons.done)
                );
              }
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),

                  baseTournamentField(
                      controller: nameController,
                      hintText: "Name",
                      focusNode: nameFocusNode,
                      nextFocusNode: descriptionFocusNode,
                    ),
                  baseTournamentField(
                    controller: descriptionController,
                    hintText: "Description",
                    focusNode: descriptionFocusNode,
                    nextFocusNode: perTeamMemberFocusNode,
                  ),
                  baseTournamentField(
                    controller: perTeamMemberController,
                    hintText: "Team Member Limit",
                    focusNode: perTeamMemberFocusNode,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Rounds", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        IconButton(icon: Icon(Icons.add_circle), onPressed: (){
                          setState(() {
                            roundList.add(RoundUiDm(roundList.length + 1, participants: []));
                          });
                        }),
                      ],
                    ),
                  )
                ]+getRoundList(),

              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getRoundList(){
    List<Widget> list = [];
    for(int i = 0; i<roundList.length;i++){
      list.add(roundWidget(roundList[i], i));
    }
    return list;

  }
  Widget baseTournamentField({
  TextEditingController controller,
    String hintText,
    Function onTap,
    TextInputType textInputType,
    FocusNode focusNode,
    FocusNode nextFocusNode,
}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        onFieldSubmitted: (value){
          if(nextFocusNode != null){
            Focus.of(context).requestFocus(nextFocusNode);
          }else{
            Focus.of(context).requestFocus(FocusNode());
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),contentPadding: EdgeInsets.only(left: 8.0),
          labelText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget roundWidget(RoundUiDm round, int position){
    return Row(
      children: [
        Expanded(
          child: ExpansionTile(
            title: Text("Round ${position+1}"),
            children: [
              baseTournamentField(
                controller: round.roundNameController,
                hintText: "Round Name",
                focusNode: round.roundNameFocus,
                nextFocusNode: round.roundDescriptionFocus,
              ),
              baseTournamentField(
                controller: round.roundDescriptionController,
                hintText: "Round Description",
                focusNode: round.roundDescriptionFocus,
                nextFocusNode: round.maxTeamFocus,
              ),
              baseTournamentField(
                controller: round.maxTeamController,
                hintText: "Max. Team Limit",
                focusNode: round.maxTeamFocus,
              ),
              getDateField(label: "Start Time", controller: round.startController),
              getDateField(label: "End Time", controller: round.endController),

            ],
          ),
        ),
        round.index>1?IconButton(icon: Icon(Icons.remove_circle), onPressed: (){
          setState(() {
            roundList[round.index-1].startController.dispose();
            roundList[round.index-1].endController.dispose();
            roundList[round.index-1].roundNameController.dispose();
            roundList[round.index-1].roundDescriptionController.dispose();
            roundList[round.index-1].roundNameFocus.dispose();
            roundList[round.index-1].roundDescriptionFocus.dispose();
            roundList[round.index-1].maxTeamFocus.dispose();
            roundList.removeAt(round.index-1);
          });
        }):Container()
      ],
    );
  }
  getDateField({String label, TextEditingController controller}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DateTimeField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),contentPadding: EdgeInsets.only(left: 8.0),
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        format: DateFormat(FirebaseUtil.dateFormat),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    );
  }
  TournamentDm getTournament(){
    TournamentDm obj = TournamentDm();
    obj.id = widget.tournamentDm?.id;
    obj.name = nameController.text;
    obj.description = descriptionController.text;
    obj.domainId = widget.domainDm.id;
    obj.perTeamMember = perTeamMemberController.text;
    obj.rounds = [];
    for(int i = 0; i<roundList.length;i++){
      RoundUiDm element = roundList[i];
      obj.rounds.add(
          Rounds(
              name: element.roundNameController.text,
              index: element.index.toString(),
              maxTeam: element.maxTeamController.text,
              roundDescription: element.roundDescriptionController?.text ?? "",
              startDate: element.startController.text,
              endDate: element.endController.text,
              participants: element.participants ?? [],
          )
      );
    }
    return obj;
  }
}


class RoundUiDm{
  int index;
  TextEditingController roundNameController;
  TextEditingController roundDescriptionController;
  TextEditingController startController;
  TextEditingController endController;
  TextEditingController maxTeamController;


  FocusNode roundNameFocus;
  FocusNode roundDescriptionFocus;
  List<Participants> participants;

  FocusNode maxTeamFocus;

  RoundUiDm(this.index, {this.participants}){
    roundNameController = TextEditingController();
    roundDescriptionController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();
    maxTeamController = TextEditingController();
    roundDescriptionFocus = FocusNode();
    roundNameFocus = FocusNode();
    maxTeamFocus = FocusNode();
  }


}