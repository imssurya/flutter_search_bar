part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchProductRequested extends SearchEvent {
  SearchProductRequested(this.searchText);

  final String searchText;
}

class SearchProductReset extends SearchEvent {
  SearchProductReset();
}
