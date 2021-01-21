part of 'last_research_bloc.dart';

abstract class LastResearchEvent extends Equatable {
  const LastResearchEvent();

  @override
  List<Object> get props => [];
}

class LastResearchSaved extends LastResearchEvent {
  LastResearchSaved({this.searchText});

  final String searchText;
}

class LastResearchHide extends LastResearchEvent {
  LastResearchHide();
}
