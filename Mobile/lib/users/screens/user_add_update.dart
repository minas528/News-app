import 'package:Mobile/users/bloc/user_bloc.dart';
import 'package:Mobile/users/bloc/user_event.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:Mobile/users/screens/user_list.dart';
import 'package:Mobile/users/screens/user_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateUser extends StatefulWidget {
  static const routeName = 'userAddUpdate';
  final UserArgument args;

  AddUpdateUser({this.args});
  @override
  _AddUpdateUserState createState() => _AddUpdateUserState();
}

class _AddUpdateUserState extends State<AddUpdateUser> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _user = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.edit ? 'Edit User' : 'Create User'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.args.edit ? widget.args.user.name : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Media Name';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'name'),
                onSaved: (value) {
                  setState(() {
                    this._user["name"] = value;
                  });
                },
              ),
              TextFormField(
                initialValue: widget.args.edit ? widget.args.user.email : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Media Email';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'email'),
                onSaved: (value) {
                  setState(() {
                    this._user["email"] = value;
                  });
                },
              ),
              TextFormField(
                initialValue: widget.args.edit ? widget.args.user.role : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Media website';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'website'),
                onSaved: (value) {
                  setState(() {
                    this._user["role"] = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        final UserEvent event = widget.args.edit
                            ? UserUpdate(
                          User(
                            id: widget.args.user.id,
                            name: this._user['name'],
                            email: this._user['email'],
                            role: this._user['role'],
                          ),
                        )
                            : UserCreate(User(
                          name: this._user['name'],
                          email: this._user['email'],
                          role: this._user['role'],
                        ));
                        BlocProvider.of<UserBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            UserList.routeName, (route) => false);
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text('Save')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
