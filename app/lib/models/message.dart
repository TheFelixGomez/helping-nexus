class Message {
  String id;
  String message;
  String fromUserId;
  String toUserId;
  DateTime createdAt;

  Message({
    required this.id,
    required this.message,
    required this.fromUserId,
    required this.toUserId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
      fromUserId: json['from_user_id'],
      toUserId: json['to_user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}