import 'package:Hackathon/domains/domain_bloc/domain_dm.dart';
import 'package:Hackathon/utils/custom_app_bar_title.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(widget.domain.color),
          child: Center(
            child: Icon(Icons.add),
          ),
          onPressed: (){},
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
      ],
    );
  }
}
