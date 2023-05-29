import 'package:equatable/equatable.dart';
import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';

class User with EquatableMixin, IdModel, BaseFirebaseModel<User> {
  String? name;
  String? surname;
  String? email;
  @override
  final String? id;

  User({
    this.id,
    this.name,
    this.surname,
    this.email,
  });

  @override
  List<Object?> get props => [id];

  User copyWith({
    String? name,
    String? surname,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
    };
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
    );
  }
}
