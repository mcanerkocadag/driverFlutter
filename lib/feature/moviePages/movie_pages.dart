import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/match/match_page.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:http/http.dart' as http;
import '../../product/models/userprofile.dart';

class MovieSearchPage extends StatefulWidget {
  final UserProfile user;
  MovieSearchPage({required this.user});

  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Results> _movies = [];

  Set<int> _selectedItemIndexes =
      Set<int>(); // Seçili öğelerin indekslerini tutan küme
  List<MovieDetail> movieList = [];

  Future<void> _searchMovies(String keyword) async {
    final apiUrl =
        'https://api.themoviedb.org/3/search/movie?api_key=137ab39a2a751ee4c1b61e7bcead4cad&query=$keyword&sort_by=popularity.desc';
    late MovieResponse? movies;
    try {
      final response = await Dio().get(apiUrl);
      movies = MovieResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }

    setState(() {
      _movies.clear();
      _movies = movies?.results ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Favourite Film...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 10.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _searchMovies(_searchController.text);
                      },
                    ),
                  ],
                )),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Sütun sayısı
                  childAspectRatio: 2, // Genişlik ve yükseklik oranı
                ),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  var movie = _movies.elementAt(index);

                  //bool isSelected = movieList.contains(index);
                  bool isSelected =
                      movieList.any((element) => element.id == movie.id);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedItemIndexes.remove(index);
                          movieList
                              .removeWhere((element) => element.id == movie.id);
                        } else {
                          _selectedItemIndexes.add(index);
                          movieList.add(MovieDetail(
                              name: movie.originalTitle ?? '',
                              type: movie.title ?? '',
                              id: movie.id ?? 0));
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isSelected
                              ? [
                                  ColorConstants.choosenItemGradientFirst,
                                  ColorConstants.choosenItemGradientLast,
                                ]
                              : [Colors.white, Colors.white],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/im_filmRecord.png',
                              width: 36,
                              height: 36,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                _movies[index].title ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  onPressed: () {
                    widget.user.movieList = movieList;
                    _saveUserData(widget.user);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MatchPage()),
                    );*/
                  },
                  child: Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _saveUserData(UserProfile userProfile) async {
  try {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    await usersCollection.add({
      'userName': userProfile.userName,
      'surname': userProfile.surname,
      'gender': userProfile.gender,
      'movieList': userProfile.movieList
          .map((movie) => {
                'name': movie.name,
                'type': movie.type,
                'id': movie.id,
              })
          .toList(),
    });

    print('Veri başarıyla kaydedildi.');
  } catch (e) {
    print('Veri kaydedilirken bir hata oluştu: $e');
  }
}

class MovieResponse with EquatableMixin {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  MovieResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];

  MovieResponse copyWith({
    int? page,
    List<Results>? results,
    int? totalPages,
    int? totalResults,
  }) {
    return MovieResponse(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results,
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      page: json['page'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int?,
      totalResults: json['total_results'] as int?,
    );
  }
}

class Results with EquatableMixin {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Results({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount
      ];

  Results copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) {
    return Results(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList(),
      id: json['id'] as int?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: json['popularity'] as double?,
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: json['vote_average'] as double?,
      voteCount: json['vote_count'] as int?,
    );
  }
}
