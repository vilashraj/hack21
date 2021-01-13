import 'package:Hackathon/domains/domain_bloc/domain_event.dart';
import 'package:Hackathon/domains/domain_bloc/domain_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain_dm.dart';
import 'domain_state.dart';

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

/// <h1>domain_bloc</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/13/21 5:53 pm
/// 

class DomainBloc extends Bloc<DomainEvent, DomainState>{
  DomainRepo domainRepo = DomainRepo();
  DomainBloc(DomainState initialState) : super(initialState);

  @override
  Stream<DomainState> mapEventToState(DomainEvent event) async*{
    if(event is FetchDomain){
      try{
        yield DomainLoading();
        List<DomainDm> domains = await domainRepo.fetchAllDomains();
        yield DomainLoaded(domains: domains);
      }catch(e){
        print(e);
        yield DomainError(e.toString());
      }
    }
  }
}