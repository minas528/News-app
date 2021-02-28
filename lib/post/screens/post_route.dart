import 'package:Mobile/post/screens/post_add_update.dart';
import 'package:Mobile/post/screens/post_detail.dart';
import 'package:Mobile/post/screens/post_list.dart';
import 'package:flutter/material.dart';
import 'package:Mobile/post/post.dart';

class PostAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if(settings.name=='//'){
      return MaterialPageRoute(builder: (context) => PostList());
    }
    if (settings.name == AddUpdatePost.routeName) {
      PostArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AddUpdatePost(
        args: args,
      ));
    }
    if (settings.name == PostDetail.routeName) {
      Post post = settings.arguments;
      return MaterialPageRoute(builder: (context) => PostDetail(post: post,));
    }
    return MaterialPageRoute(builder: (context) => PostList());
  }


}
class PostArguments {
  final Post post;
  final bool edit;
  PostArguments({this.post, this.edit});
}