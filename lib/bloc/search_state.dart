part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  const SearchLoaded({@required this.products}) : assert(products != null);

  final List<Product> products;

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductLoaded(products: $products)';
}

class SearchFailure extends SearchState {}
