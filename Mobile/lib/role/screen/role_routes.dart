
import 'package:Mobile/role/model/models.dar.dart';
import 'package:Mobile/role/screen/role_add_update.dart';
import 'package:Mobile/role/screen/role_details.dart';
import 'package:Mobile/role/screen/role_list.dart';
import 'package:flutter/material.dart';



class RoleAppRoute {
  static Route generateRoute(RouteSettings settings){
    if(settings.name == '/role'){
      return MaterialPageRoute(builder: (context) => RoleList());
    }
    if(settings.name == AddUpdateRole.routeName) {
      RoleArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context) => AddUpdateRole(args: args,));
    }
    if(settings.name == RoleDetails.routeName){
      Role role = settings.arguments;
      return MaterialPageRoute(builder: (context) => RoleDetails(role: role));
    }
    return MaterialPageRoute(builder: (context) => RoleList());
  }
}
class RoleArgument {
  final Role role;
  final bool edit;
  RoleArgument({this.role, this.edit});
}