import 'package:equatable/equatable.dart';
import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';

class News extends Equatable with IdModel, BaseFirebaseModel<News> {
  @override
  final String? id;
  final String? category;
  final String? categoryId;
  final String? title;
  final String? backgroundImage;

  News({
    this.id,
    this.category,
    this.categoryId,
    this.title,
    this.backgroundImage,
  });

  @override
  List<Object?> get props => [id, category, categoryId, title, backgroundImage];

  News copyWith({
    String? id,
    String? category,
    String? categoryId,
    String? title,
    String? backgroundImage,
  }) {
    return News(
      id: id ?? this.id,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'categoryId': categoryId,
      'title': title,
      'backgroundImage': backgroundImage,
    };
  }

  @override
  News fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] as String?,
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      title: json['title'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
    );
  }
}
