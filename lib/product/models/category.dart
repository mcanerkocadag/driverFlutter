// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';

@immutable
class Category with EquatableMixin, IdModel, BaseFirebaseModel<Category> {
  final String? name;
  final String? detail;
  @override
  final String? id;

  Category({this.name, this.detail, this.id});

  @override
  List<Object?> get props => [id];

  Category copyWith({
    String? name,
    String? detail,
    String? id,
  }) {
    return Category(
      name: name ?? this.name,
      detail: detail ?? this.detail,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'detail': detail,
    };
  }

  @override
  Category fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String?,
      detail: json['detail'] as String?,
      id: json['id'] as String?,
    );
  }
}
