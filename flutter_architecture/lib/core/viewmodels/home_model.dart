import 'package:flutter_architecture/core/enums/viewstate.dart';
import 'package:flutter_architecture/core/models/post.dart';
import 'package:flutter_architecture/core/services/api.dart';
import 'package:flutter_architecture/locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  final Api _api = locator<Api>();

  List<Post> posts = [];

  Future getPosts(int userId) async {
    setState(ViewState.busy);
    posts = await _api.getPostsFromUser(userId);
    setState(ViewState.idle);
  }
}