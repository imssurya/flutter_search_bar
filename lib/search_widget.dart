import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastResearch/product/product_repository.dart';

import 'bloc/last_research_bloc.dart';
import 'bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  final productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
            create: (BuildContext context) => SearchBloc(productRepository)),
        BlocProvider<LastResearchBloc>(
            create: (BuildContext context) => LastResearchBloc()),
      ],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _FormProductSearch(textController: _textController),
            BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              if (state is SearchInitial) {
                return const SizedBox(
                  height: 1,
                );
              }

              if (state is SearchLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SearchFailure) {
                return const Center(child: Text('Something went wrong!'));
              }

              if (state is SearchLoaded) {
                if (state.products.isEmpty)
                  return const Center(
                    child: Text('No result found'),
                  );
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        BlocProvider.of<LastResearchBloc>(context).add(
                            LastResearchSaved(
                                searchText: _textController.text));
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                                state.products[index].images[0].cachedPath),
                          ),
                          Flexible(child: Text('${state.products[index].name}'))
                        ],
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemCount: state.products.length,
                  ),
                );
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}

class _FormProductSearch extends StatelessWidget {
  const _FormProductSearch({
    Key key,
    @required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  hintText: 'Chicago',
                ),
                onChanged: (value) {
                  if (value.isEmpty)
                    Timer(const Duration(milliseconds: 500), () {
                      context.read<LastResearchBloc>().add(LastResearchSaved());
                      context.read<SearchBloc>().add(SearchProductReset());
                    });
                  if (value.isNotEmpty)
                    Timer(const Duration(milliseconds: 500), () {
                      context.read<LastResearchBloc>().add(LastResearchHide());
                      context
                          .read<SearchBloc>()
                          .add(SearchProductRequested(value));
                    });
                }),
          ),
          BlocBuilder<LastResearchBloc, LastResearchState>(
              buildWhen: (previousState, state) {
            return true;
          }, builder: (context, state) {
            if (state is LastResearchInitial || state is LastResearchHidden) {
              return const SizedBox(
                height: 1,
              );
            }

            if (state is LastResearchLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LastResearchFailure) {
              return const Center(child: Text('Something went wrong!'));
            }

            if (state is LastResearchLoaded) {
              if (_textController.text.isEmpty)
                return Column(
                  children: _getChildrens(state.searchs, context),
                );
              return const Text('');
            }
            return Container();
          })
        ],
      ),
    );
  }

  List<Widget> _getChildrens(List<String> searchs, BuildContext context) {
    final list = <Widget>[];
    list.add(SizedBox(
      height: 20,
    ));
    for (final search in searchs) {
      list.add(InkWell(
        onTap: () {
          _textController.text = search;
          context.read<SearchBloc>().add(SearchProductRequested(search));
          context.read<LastResearchBloc>().add(LastResearchHide());
        },
        child: Row(
          children: [
            const Icon(Icons.restore),
            Text('$search'),
          ],
        ),
      ));
    }
    return list;
  }
}
