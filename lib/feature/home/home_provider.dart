// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_firebase/product/models/news.dart';
import 'package:flutter_application_firebase/product/models/recommended.dart';
import 'package:flutter_application_firebase/product/models/tag.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_utility.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  List<Tag>? _fullTagList = [];
  List<Tag>? get fullTagList => _fullTagList;

  Future<void> fetchRecommended() async {
    final values = await fetchList<Recommended, Recommended>(
        Recommended(), FirebaseCollections.recomended);
    state = state.copyWith(recommended: values);
  }

  Future<void> fetchNews() async {
    final values =
        await fetchList<News, News>(News(), FirebaseCollections.news);
    state = state.copyWith(news: values);
/**
    final newsCollectionReference = FirebaseCollections.news.referance;
    final response = await newsCollectionReference.withConverter(
      fromFirestore: (snapshot, options) {
        return News().fromFirebase(snapshot) ?? News();
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();

    print("data x: ${response}");
    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(news: values);
    }
    **/
  }

  Future<void> fetcTags() async {
    final newsCollectionReference = FirebaseCollections.tag.referance;
    final response = await newsCollectionReference.withConverter(
      fromFirestore: (snapshot, options) {
        return Tag().fromFirebase(snapshot) ?? Tag();
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(tags: values);
      _fullTagList = values;
    }
  }

  Future<void> fetchAndLoad() async {
    try {
      state = state.copyWith(isLoading: true);
      await Future.wait([fetchNews(), fetcTags(), fetchRecommended()]);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      print(e);
    }
  }

  void updateSelectedTag(Tag? tag) {
    if (tag == null) return;
    state = state.copyWith(selectedTag: tag);
  }
}

class HomeState extends Equatable {
  const HomeState(
      {this.tags,
      this.news,
      this.recommended,
      this.isLoading,
      this.selectedTag});

  final List<News>? news;
  final List<Tag>? tags;
  final List<Recommended>? recommended;
  final bool? isLoading;
  final Tag? selectedTag;
  @override
  // TODO: implement props
  List<Object?> get props => [tags, news, isLoading, selectedTag];

  HomeState copyWith({
    List<News>? news,
    List<Tag>? tags,
    List<Recommended>? recommended,
    bool? isLoading,
    Tag? selectedTag,
  }) {
    return HomeState(
      news: news ?? this.news,
      tags: tags ?? this.tags,
      recommended: recommended ?? this.recommended,
      isLoading: isLoading ?? this.isLoading,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }
}
