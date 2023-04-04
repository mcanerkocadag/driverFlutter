// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';

@immutable
class Recommended with EquatableMixin, IdModel, BaseFirebaseModel<Recommended> {
  Recommended({this.image, this.title, this.description, this.id});
  final String? image;
  final String? title;
  final String? description;
  @override
  final String? id;

  @override
  List<Object?> get props => [image, title, description];

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
    };
  }

  @override
  Recommended fromJson(Map<String, dynamic> json) {
    return Recommended(
      image: json['image'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  Recommended copyWith({
    String? image,
    String? title,
    String? description,
    String? id,
  }) {
    return Recommended(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }
}
