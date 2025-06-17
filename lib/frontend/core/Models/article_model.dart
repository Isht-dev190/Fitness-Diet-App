import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 12)
class Article {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String date;

  @HiveField(5)
  final String? content;

  @HiveField(6)
  bool isLiked;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.content,
    this.isLiked = false,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      date: json['date'] ?? '',
      content: json['content'],
      isLiked: json['is_liked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'content': content,
      'is_liked': isLiked,
    };
  }

  Article copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? date,
    String? content,
    bool? isLiked,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      content: content ?? this.content,
      isLiked: isLiked ?? this.isLiked,
    );
  }
} 