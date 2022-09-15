import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_architecture/core/models/post.dart';
import 'package:flutter_architecture/core/models/user.dart';
import 'package:flutter_architecture/ui/shared/app_colors.dart';
import 'package:flutter_architecture/ui/shared/text_styles.dart';
import 'package:flutter_architecture/ui/shared/ui_helpers.dart';
import 'package:flutter_architecture/ui/widgets/comments.dart';

class PostView extends StatelessWidget {
  final Post post;
  const PostView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Text(post.title ?? '', style: headerStyle),
            Text(
              'by ${Provider.of<User>(context).name}',
              style: const TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(post.body ?? ''),
            Comments(post.id!)
          ],
        ),
      ),
    );
  }
}