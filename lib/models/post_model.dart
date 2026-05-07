class PostModel {
  PostModel({
    required this.id,
    required this.type,
    required this.creationDate,
    required this.authorId,
    required this.authorName,
    required this.content,
    this.likes = const [],
    this.caption,
    this.reposts,
    this.savedBy = const [],
    this.sent,
  });

  final int id;
  final List<String> likes;
  final String? caption;
  final String type;
  final int? reposts;
  final int? sent;
  final DateTime creationDate;
  final String content;
  // User Info
  final int authorId;
  final String authorName;
  // Saved By Info
  final List<String> savedBy;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      authorId: int.parse(json['author_id']),
      content: json['content'],
      creationDate: DateTime.parse(json['creation_date']),
      id: int.parse(json['id'].toString()),
      type: json['type'],
      authorName: json['author_name'],
      caption: json['caption'],
      likes: List<String>.from(json['likes'] ?? []),
      reposts: json['reposts'],
      savedBy: List<String>.from(json['savedBy'] ?? []),
      sent: json['sent'],
    );
  }

  factory PostModel.getEmptyObject() {
    return PostModel(
      id: 0,
      type: 'video',
      creationDate: DateTime.now(),
      authorId: 0,
      authorName: '',
      content: '',
      likes: [],
      caption: '',
      reposts: 0,
      savedBy: [],
      sent: 0,
    );
  }
}
