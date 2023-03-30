import 'package:equatable/equatable.dart';
import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';

class Number extends Equatable with IdModel, BaseFirebaseModel<Number> {
  final String? number;

  Number({
    this.number,
  });

  @override
  List<Object?> get props => [number];

  Number copyWith({
    String? number,
  }) {
    return Number(
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }

  @override
  Number fromJson(Map<String, dynamic> json) {
    return Number(
      number: json['number'] as String?,
    );
  }
}
