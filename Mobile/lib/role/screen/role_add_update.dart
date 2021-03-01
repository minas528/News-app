
import 'package:Mobile/role/bloc/bloc.dart';
import 'package:Mobile/role/model/Role.dart';
import 'package:Mobile/role/screen/role_list.dart';
import 'package:Mobile/role/screen/role_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateRole extends StatefulWidget {
  static const routeName = 'roleAddUpdate';
  final RoleArgument args;

  AddUpdateRole({this.args});
  @override
  _AddUpdateRoleState createState() => _AddUpdateRoleState();
}

class _AddUpdateRoleState extends State<AddUpdateRole> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _media = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.edit ? 'Edit Role' : 'Create Role'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.args.edit ? widget.args.role.name : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Role Name';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'name'),
                onSaved: (value) {
                  setState(() {
                    this._media["name"] = value;
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
                        final RoleEvent event = widget.args.edit
                            ? RoleUpdate(
                          Role(
                            id: widget.args.role.id,
                            name: this._media['name'],
                          ),
                        )
                            : RoleCreate(Role(
                          name: this._media['name'],
                        ));
                        BlocProvider.of<RoleBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            RoleList.routeName, (route) => false);
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
