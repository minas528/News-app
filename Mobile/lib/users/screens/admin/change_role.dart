
import 'package:Mobile/role/bloc/role_bloc.dart';
import 'package:Mobile/role/bloc/role_state.dart';
import 'package:Mobile/role/model/Role.dart';
import 'package:Mobile/users/bloc/user_bloc.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeRole extends StatefulWidget {
  static const String routeName = '/changerole';
  final User user;

  const ChangeRole({Key key, this.user}) : super(key: key);

  @override
  _ChangeRoleState createState() => _ChangeRoleState();
}

class _ChangeRoleState extends State<ChangeRole> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController roleController = TextEditingController();
  String role;
  Role selectedRole;

  buildRoleDropDown(List<Role> roles) {
    if (selectedRole == null) {
      selectedRole = roles[0];
    }
    return Container(
      child: ListTile(
        leading: Text(
          "Select Role",
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: DropdownButton(
          value: this.selectedRole,
          items: roles.map((role) {
            return DropdownMenuItem(
              child: Text(role.name),
              value: role,
            );
          }).toList(),
          onChanged: (Role selected) {
            setState(() {
              this.selectedRole = selected;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Role'),
      ),
      body: BlocConsumer<RoleBloc, RoleState>(
          builder: (context, state) {
            if (state is RoleLoadSuccess) {
              return Form(
                  key: _formKey,
                  child: Column(children: [
                    Text(
                      widget.user.username,
                      style: TextStyle(fontSize: 30.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildRoleDropDown(state.role),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();

                            BlocProvider.of<UserBloc>(context).add(
                                UserRoleUpdate(
                                    userId: widget.user.id,
                                    roleId: selectedRole.id));
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                          }
                        },
                        icon: Icon(Icons.save),
                        label: Text('SAVE'),
                      ),
                    )
                  ]));
            } else {
              return Text("Error");
            }
          },
          listener: (context, state) {}),
    );
  }
}