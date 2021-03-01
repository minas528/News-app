import 'package:Mobile/auth/bloc/auth_bloc.dart';
import 'package:Mobile/auth/bloc/auth_state.dart';
import 'package:Mobile/auth/screens/login_screen.dart';
import 'package:Mobile/home.dart';
import 'package:Mobile/media/screens/media_add_update.dart';
import 'package:Mobile/media/screens/media_details.dart';
import 'package:Mobile/media/screens/media_list.dart';
import 'package:Mobile/media/screens/media_route.dart';
import 'package:Mobile/news/model/Post.dart';
import 'package:Mobile/news/screens/post_add_update.dart';
import 'package:Mobile/news/screens/post_detail.dart';
import 'package:Mobile/news/screens/post_list.dart';
import 'package:Mobile/news/screens/post_route.dart';
import 'package:Mobile/role/model/models.dar.dart';
import 'package:Mobile/role/screen/role_add_update.dart';
import 'package:Mobile/role/screen/role_details.dart';
import 'package:Mobile/role/screen/role_list.dart';
import 'package:Mobile/role/screen/role_routes.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:Mobile/users/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/screens/register_screen.dart';
import 'media/model/Media.dart';

class PageRouter {
  static Route onGenerateRoute(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (cotext){
        return BlocBuilder<AuthBloc,AuthState>(
          builder: (context, state){
            if (state is AuthenticationAuthenticated){
              if(state.user.role =="ADMIN"){
                // return AdminDashboard();
              }else if(state.user.role=='USER'){
                return Home();
              } else if (state.user.role=='JORNALIST'){
                return Home();
              }
            }
            return LoginPage();
          }

        );

      });
    }
    if (settings.name == "/login"){
      return MaterialPageRoute(builder: (context){
        return LoginPage();
      });
    }
    if(settings.name == "/register"){
      return MaterialPageRoute(builder: (context) {
        return SignUpPage();
      });
    }
    if(settings.name == PostList.routeName){
      return MaterialPageRoute(builder: (context){
        return PostList();
      });
    }
    if(settings.name == PostDetail.routeName){
      Post post = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return PostDetail(post: post);
      });
    }
    if(settings.name == AddUpdatePost.routeName){
      PostArguments args = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return AddUpdatePost(args: args,);
      });
    }

    if(settings.name == MediaList.routeName){
      return MaterialPageRoute(builder: (context){
        return MediaList();
      });
    }
    if(settings.name == MediaDetails.routeName){
      Media media = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return MediaDetails(media: media);
      });
    }
    if(settings.name == AddUpdateMedia.routeName){
      MediaArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return AddUpdateMedia(args: args,);
      });
    }

    if(settings.name == UserList.routeName){
      return MaterialPageRoute(builder: (context){
        return UserList();
      });
    }
    if(settings.name == UserDetails.routeName){
      User user = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return UserDetails(user: user);
      });
    }
    if(settings.name == AddUpdateUser.routeName){
      UserArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return AddUpdateUser(args: args,);
      });
    }

    if(settings.name == RoleList.routeName){
      return MaterialPageRoute(builder: (context){
        return RoleList();
      });
    }
    if(settings.name == RoleDetails.routeName){
      Role role = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return RoleDetails(role:role);
      });
    }
    if(settings.name == AddUpdateRole.routeName){
      RoleArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context){
        return AddUpdateRole(args: args,);
      });
    }

  }
}