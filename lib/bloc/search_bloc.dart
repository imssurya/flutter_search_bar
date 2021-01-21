import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lastResearch/product/models/models.dart';
import 'package:lastResearch/product/product_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.productRepository)
      : assert(productRepository != null),
        super(SearchInitial());

  final ProductRepository productRepository;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchProductRequested) {
      yield SearchLoading();
      try {
        final products = await productRepository.findByName(event.searchText);
        yield SearchLoaded(products: products);
      } catch (_) {
        yield SearchFailure();
      }
    }
    if (event is SearchProductReset) {
      yield SearchInitial();
    }
  }
}
