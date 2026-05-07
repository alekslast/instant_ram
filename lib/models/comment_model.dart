class CommentModel {
  final int id;
  final String text;
  final DateTime datePublished;
  final int likes;

  final String authorNickname;
  final int postId;

  CommentModel({
    required this.id,
    required this.text,
    required this.datePublished,
    required this.likes,
    required this.authorNickname,
    required this.postId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    int tryParseInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return CommentModel(
      id: tryParseInt(json['id']),
      text: json['text'] as String? ?? '',
      datePublished: json['date_published'] != null
          ? DateTime.parse(json['date_published'].toString())
          : DateTime.now(),
      likes: tryParseInt(json['likes']),
      authorNickname: json['author_nickname'] as String? ?? 'Anonymous',
      postId: tryParseInt(json['post_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'date_published': datePublished,
      'likes': likes,
      'author_nickname': authorNickname,
      'post_id': postId,
    };
  }

  factory CommentModel.getEmptyObject() {
    return CommentModel(
      id: 0,
      text: '',
      datePublished: DateTime.now(),
      likes: 0,
      authorNickname: '',
      postId: 0,
    );
  }
}
