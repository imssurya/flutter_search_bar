part of 'last_research_bloc.dart';

abstract class LastResearchState extends Equatable {
  const LastResearchState();

  @override
  List<Object> get props => [];
}

class LastResearchInitial extends LastResearchState {}

class LastResearchLoading extends LastResearchState {}

class LastResearchLoaded extends LastResearchState {
  const LastResearchLoaded({@required this.searchs}) : assert(searchs != null);

  final List<String> searchs;

  @override
  List<Object> get props => [searchs];

  @override
  String toString() => 'lastReashearLoaded(products: $searchs)';
}

class LastResearchHidden extends LastResearchState {
  const LastResearchHidden({@required this.searchs}) : assert(searchs != null);

  final List<String> searchs;

  @override
  List<Object> get props => [searchs];

  @override
  String toString() => 'lastReashearLoaded(products: $searchs)';
}

class LastResearchFailure extends LastResearchState {}
