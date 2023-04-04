import 'package:flutter/material.dart';

import 'package:flutter_application_firebase/product/models/tag.dart';

class HomeSearchDelegate extends SearchDelegate<Tag?> {
  HomeSearchDelegate(this.tags);

  final List<Tag>? tags;
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = tags?.where((element) =>
        element.name?.toLowerCase().contains(query.toLowerCase()) ?? false);
    return ListView.builder(
      itemCount: results?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              close(context, results?.elementAt(index));
            },
            title: Text(results?.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }
}
