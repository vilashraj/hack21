import 'package:Hackathon/domains/domain_bloc/domain_event.dart';
import 'package:Hackathon/tournament/tournament_screen.dart';
import 'package:Hackathon/utils/base_empty_screen.dart';
import 'package:Hackathon/utils/custom_app_bar_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain_bloc/domain_bloc.dart';
import 'domain_bloc/domain_dm.dart';
import 'domain_bloc/domain_state.dart';

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

/// <h1>domain_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 6:47 pm
/// 

class DomainScreen extends StatefulWidget {
  @override
  _DomainScreenState createState() => _DomainScreenState();
}

class _DomainScreenState extends State<DomainScreen> {

  DomainBloc domainBloc;

  @override
  void initState() {
    domainBloc = DomainBloc(DomainUninitialized());
    domainBloc.add(FetchDomain());
    super.initState();
  }
  @override
  void dispose() {
    domainBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    return Column(
      children: [
        CustomAppBarTitle("Domains"),
        Expanded(
          child: BlocBuilder(
            cubit: domainBloc,
            builder: (context, DomainState state){
              if(state is DomainUninitialized || state is DomainLoading){
               return getLoader();
              }
              else if(state is DomainError){
                return EmptyScreen.error(title: "Failed to fetch domains",onClick: (){
                  domainBloc.add(FetchDomain());
                },);
              }
              else if(state is DomainLoaded){
                return getSlider(state.domains);
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget getLoader(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget getSlider(List<DomainDm> domains){

    return CarouselSlider(
      items: getItems(domains),
      options: CarouselOptions(
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        height: MediaQuery.of(context).size.height * 0.7,

      ),
    );
  }
  List<Widget> getItems(List<DomainDm> domains){
    List<Widget> list = [];
    domains.forEach((element) {
      list.add(getDomainCard(element));
    });
    return list;
  }
  Widget getDomainCard(DomainDm domain){
    return Hero(
      tag: domain.id,
      child: Material(
        type: MaterialType.transparency,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 10.0,
          child: ClipRect(
            child: Container(
              decoration: BoxDecoration(
                  color: Color(domain.color),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: ClipRect(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Expanded(flex: 1,child: Center(child: ClipRect(child: Text(domain.name, textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 30,  fontWeight: FontWeight.bold),)))),
                        Expanded(flex: 2,child: ClipRect(child: Text(domain.tagLine, textAlign: TextAlign.center,style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14,  fontStyle: FontStyle.italic),))),

                    ],
                  ),
                      )),
                  Expanded(flex: 2,child: ClipRect(child: Center(child: CachedNetworkImage(imageUrl: domain.image,color: Colors.white.withOpacity(0.9), width: 200,)))),
                  Expanded(flex: 1, child: ClipRect(
                    child: Center(child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) => TournamentScreen(domain),
                              transitionDuration: Duration(milliseconds: 500),
                            ),
                        );
                      },
                      child: Text("View", style: TextStyle(color:  Colors.white),),)),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}
