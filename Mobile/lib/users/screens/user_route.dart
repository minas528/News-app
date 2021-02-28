import 'package:Mobile/users/model/User.dart';
import 'package:Mobile/users/screens/user_add_update.dart';
import 'package:Mobile/users/screens/user_details.dart';
import 'package:Mobile/users/screens/user_list.dart';
import 'package:flutter/material.dart';


class UserAppRoute {
  static Route generateRoute(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (context) => UserList());
    }
    if(settings.name == AddUpdateUser.routeName) {
      UserArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AddUpdateUser(args: args,));
    }
    if(settings.name == UserDetails.routeName){
      User user = settings.arguments;
      return MaterialPageRoute(builder: (context) => UserDetails(user: user,));
    }
    return MaterialPageRoute(builder: (context) => UserList());
  }
}
class UserArgument {
  final User user;
  final bool edit;
  UserArgument({this.user, this.edit});
}