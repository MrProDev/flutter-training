import 'dart:convert';

import 'package:flutter_architecture/core/models/comment.dart';
import 'package:flutter_architecture/core/models/post.dart';
import 'package:flutter_architecture/core/models/user.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:http/http.dart' as http;

@LazySingleton()
class Api {
  static const endPointUrl = 'https://jsonplaceholder.typicode.com';

  var client = http.Client();

  Future<List<Comment>> getCommentsForPost(int postId) async {
    List<Comment> comments = [];
    var response = await client.get(
      Uri.parse('$endPointUrl/comments?postId=$postId'),
    );
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var comment in parsed) {
      comments.add(Comment.fromJson(comment));
    }
    return comments;
  }

  Future<List<Post>> getPostsFromUser(int userId) async {
    List<Post> posts = [];
    var response = await client.get(
      Uri.parse('$endPointUrl/posts?userId=$userId'),
    );
    var parsed = json.decode(response.body) as List<dynamic>;
    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }

  Future<User> getUserProfile(int userId) async {
    var response = await client.get(
      Uri.parse('$endPointUrl/users/$userId'),
    );
    return User.fromJson(json.decode(response.body));
  }
}
