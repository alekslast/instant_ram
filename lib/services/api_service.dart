import 'dart:convert';

import 'package:instant_ram/models/comment_model.dart';
import 'package:instant_ram/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = 'http://10.0.2.2:8011/api';
  static const String baseUrl = 'http://192.168.0.14:8011/api';

  static Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/post/all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => PostModel.fromJson(json)).toList();
    }

    throw Exception('Failed to load posts');
  }

  static Future<List<CommentModel>> fetchComments(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/comment/all/$postId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((json) => CommentModel.fromJson(json)).toList();
    }

    throw Exception('Failed to load comments');
  }
}
