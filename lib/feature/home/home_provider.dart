// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_firebase/product/models/news.dart';
import 'package:flutter_application_firebase/product/utility/exception/custom_exception.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_collections.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState());

  Future<void> fetchNews() async {
    final newsCollectionReference = FirebaseCollections.news.referance;
    final response = await newsCollectionReference.withConverter(
      fromFirestore: (snapshot, options) {
        return News().fromFirebase(snapshot) ?? News();
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(news: values);
    }
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);
    await fetchNews();
    state = state.copyWith(isLoading: false);
  }
}

class HomeState extends Equatable {
  const HomeState({this.news, this.isLoading});

  final List<News>? news;
  final bool? isLoading;
  @override
  // TODO: implement props
  List<Object?> get props => [news, isLoading];

  HomeState copyWith({
    List<News>? news,
    bool? isLoading,
  }) {
    return HomeState(
      news: news ?? this.news,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
