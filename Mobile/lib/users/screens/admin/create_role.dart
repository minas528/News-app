import 'package:Mobile/role/bloc/role_bloc.dart';
import 'package:Mobile/role/bloc/role_event.dart';
import 'package:Mobile/role/model/Role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRole extends StatefulWidget {
  static const String routeName = 'createRole';

  @override
  _CreateRoleState createState() => _CreateRoleState();
}

class _CreateRoleState extends State<CreateRole> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController roleController = TextEditingController();
  String role;
  final Map<String, dynamic> _roles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Role'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter First Name';
                }
                return null;
              },
              controller: roleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Role Name',
                focusColor: Color(0xff4064f3),
                labelStyle: TextStyle(
                  color: Color(0xff4064f3),
                ),
                border: InputBorder.none,
                filled: true,
                fillColor: Color(0xfff3f3f4),
              ),
              onSaved: (value) {
                setState(() {
                  this._roles['roleName'] = value;
                  this.role = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  this.role = value;
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
                    final RoleEvent event = RoleCreate(
                      Role(
                        name: this.role,
                      ),
                    );
                    BlocProvider.of<RoleBloc>(context).add(event);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
                icon: Icon(Icons.save),
                label: Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}