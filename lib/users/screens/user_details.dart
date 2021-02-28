import 'package:Mobile/users/bloc/user_bloc.dart';
import 'package:Mobile/users/bloc/user_event.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:Mobile/users/screens/user_add_update.dart';
import 'package:Mobile/users/screens/user_list.dart';
import 'package:Mobile/users/screens/user_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserDetails extends StatelessWidget {
  static const routeName = 'userDetails';
  final User user;
  UserDetails({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.user.name),
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Name: ${this.user.name}'),
              subtitle: Text('Email: ${this.user.email}'),
            ),
            Text(
              'Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(this.user.role),
            Padding(
              padding: const EdgeInsets.all(55.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child:Icon(Icons.edit),
                      onPressed: () => Navigator.of(context).pushNamed(
                        AddUpdateUser.routeName,
                        arguments: UserArgument(user: this.user, edit: true),
                      ),
                    ),
                    RaisedButton(
                        child: Icon(Icons.delete),
                        onPressed: () {
                          context.read<UserBloc>().add(UserDelete(this.user));
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              UserList.routeName, (route) => false);
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
