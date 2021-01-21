import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'last_research_event.dart';
part 'last_research_state.dart';

class LastResearchBloc extends Bloc<LastResearchEvent, LastResearchState> {
  LastResearchBloc() : super(LastResearchInitial()) {
    // hydrate();
  }

  @override
  Stream<LastResearchState> mapEventToState(
    LastResearchEvent event,
  ) async* {
    final currentState = state;
    if (event is LastResearchSaved) {
      try {
        if (currentState is LastResearchInitial) {
          yield LastResearchLoaded(searchs: [event.searchText]);
          return;
        }

        if (currentState is LastResearchHidden) {
          if (event.searchText == null) {
            yield LastResearchLoaded(searchs: currentState.searchs);
            return;
          } else {
            currentState.searchs.add(event.searchText);
          }
          yield LastResearchLoaded(
              searchs: currentState.searchs); // I WOULD LIKE TO DO THIS ?
        }

        if (currentState is LastResearchLoaded) {
          if (event.searchText == null) {
            yield LastResearchLoaded(searchs: currentState.searchs);
            return;
          }

          if (currentState.searchs.length >= 9) {
            currentState.searchs.removeAt(0);
          }

          if (event.searchText != null) {
            currentState.searchs.add(event.searchText);
          }
          yield LastResearchLoaded(searchs: currentState.searchs);
        }
      } catch (_) {
        yield LastResearchFailure();
      }
    }
    if (event is LastResearchHide) {
      if (currentState is LastResearchLoaded) {
        yield LastResearchHidden(
            searchs: currentState.searchs); // I WOULD LIKE TO DO THIS ?
      }
    }
  }
}
