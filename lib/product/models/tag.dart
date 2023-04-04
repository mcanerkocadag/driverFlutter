// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';

@immutable
class Tag with EquatableMixin, IdModel, BaseFirebaseModel<Tag> {
  @override
  final String? id;
  final String? name;
  final bool? active;

  Tag({
    this.id,
    this.name,
    this.active,
  });

  @override
  List<Object?> get props => [name, active];

  Tag copyWith({
    String? name,
    bool? active,
  }) {
    return Tag(
      name: name ?? this.name,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'active': active,
    };
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'] as String?,
      active: json['active'] as bool?,
    );
  }
}
