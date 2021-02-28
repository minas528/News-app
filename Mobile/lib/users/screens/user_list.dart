import 'package:Mobile/users/bloc/user_bloc.dart';
import 'package:Mobile/users/bloc/user_state.dart';
import 'package:Mobile/users/screens/user_add_update.dart';
import 'package:Mobile/users/screens/user_details.dart';
import 'package:Mobile/users/screens/user_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Users'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          if(state is UserOperationFailure){
            return Text('Not able to display List of Medias');
          }
          if(state is UserLoadSuccess) {
            final users = state.user;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text('${users[index].name}'),
                  subtitle: Text('${users[index].email}'),
                  onTap: () => Navigator.of(context).pushNamed(UserDetails.routeName, arguments: users[index]),
                ));
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AddUpdateUser.routeName, arguments: UserArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
