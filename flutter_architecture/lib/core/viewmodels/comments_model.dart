import 'package:flutter_architecture/core/enums/viewstate.dart';
import 'package:flutter_architecture/core/models/comment.dart';
import 'package:flutter_architecture/core/services/api.dart';

import '../../locator.dart';
import 'base_model.dart';

class CommentsModel extends BaseModel {
  final Api _api = locator<Api>();

  List<Comment> comments = [];

  Future fetchComments(int postId) async {
    setState(ViewState.busy);
    comments = await _api.getCommentsForPost(postId);
    setState(ViewState.idle);
  }
}
