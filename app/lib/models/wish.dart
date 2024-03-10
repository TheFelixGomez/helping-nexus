import 'location.dart';

class Wish {
  String id;
  String userId;
  String title;
  Location location;
  String description;
  DateTime createdAt;

  Wish({
    required this.id,
    required this.userId,
    required this.title,
    required this.location,
    required this.description,
    required this.createdAt,
  });

  factory Wish.fromJson(Map<String, dynamic> json) {
    return Wish(
      id: json['_id'],
      userId: json['user_id'],
      title: json['title'],
      location: Location.fromJson(json['location']),
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'location': location.toJson(),
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}