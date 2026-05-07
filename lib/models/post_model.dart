class PostModel {
  final int id;
  final List<dynamic>? likes;
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
  final List<dynamic>? savedBy;

  PostModel({
    required this.id,
    required this.type,
    required this.creationDate,
    required this.authorId,
    required this.authorName,
    required this.content,
    this.likes,
    this.caption,
    this.reposts,
    this.savedBy,
    this.sent,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      authorId: int.parse(json['author_id']),
      content: json['content'],
      creationDate: DateTime.parse(json['creation_date']),
      id: int.parse(json['id'].toString()),
      type: json['type'],
      authorName: json['author_name'],
      caption: json['caption'],
      likes: json['likes'],
      reposts: json['reposts'],
      savedBy: json['savedBy'],
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
