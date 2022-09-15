import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/models/post.dart';
import 'package:flutter_architecture/ui/views/home_view.dart';
import 'package:flutter_architecture/ui/views/login_view.dart';
import 'package:flutter_architecture/ui/views/post_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case 'post':
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
