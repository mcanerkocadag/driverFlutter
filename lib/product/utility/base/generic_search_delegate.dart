import 'package:flutter/material.dart';

class GenericSearchDelegate<T> extends SearchDelegate<T?> {
  final List<T> items;
  final String Function(T item) searchLabel;
  final Widget Function(T item) buildResult;
  final Widget Function(BuildContext context, T item) buildSuggestion;

  GenericSearchDelegate({
    required this.items,
    required this.searchLabel,
    required this.buildResult,
    required this.buildSuggestion,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        items.where((item) => searchLabel(item).contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => close(context, results[index]),
        child: buildResult(results[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<T> suggestions;
    suggestions =
        items.where((item) => searchLabel(item).contains(query)).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => close(context, suggestions[index]),
        child: buildSuggestion(context, suggestions[index]),
      ),
    );
  }
}
