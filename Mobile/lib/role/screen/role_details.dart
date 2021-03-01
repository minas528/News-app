
import 'package:Mobile/role/bloc/bloc.dart';
import 'package:Mobile/role/model/models.dar.dart';
import 'package:Mobile/role/screen/role_add_update.dart';
import 'package:Mobile/role/screen/role_list.dart';
import 'package:Mobile/role/screen/role_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class RoleDetails extends StatelessWidget {
  static const routeName = 'roleDetails';
  final Role role;
  RoleDetails({this.role});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.role.name),
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Name: ${this.role.name}'),
            ),

            Padding(
              padding: const EdgeInsets.all(55.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child:Icon(Icons.edit),
                      onPressed: () => Navigator.of(context).pushNamed(
                        AddUpdateRole.routeName,
                        arguments: RoleArgument(role: this.role, edit: true),
                      ),
                    ),
                    RaisedButton(
                        child: Icon(Icons.delete),
                        onPressed: () {
                          context.read<RoleBloc>().add(RoleDelete(this.role));
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              RoleList.routeName, (route) => false);
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
