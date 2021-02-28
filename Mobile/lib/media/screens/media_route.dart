import 'package:Mobile/media/screens/media_add_update.dart';
import 'package:Mobile/media/screens/media_details.dart';
import 'package:Mobile/media/screens/media_list.dart';
import 'package:Mobile/post/screens/post_add_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../media.dart';

class MediaAppRoute {
  static Route generateRoute(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (context) => MediaList());
    }
    if(settings.name == AddUpdatePost.routeName) {
      MediaArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AddUpdateMedia(args: args,));
    }
    if(settings.name == MediaDetails.routeName){
      Media media = settings.arguments;
      return MaterialPageRoute(builder: (context) => MediaDetails(media: media,));
    }
    return MaterialPageRoute(builder: (context) => MediaList());
  }
}
class MediaArgument {
  final Media media;
  final bool edit;
  MediaArgument({this.media, this.edit});
}