
import 'package:Mobile/role/bloc/bloc.dart';
import 'package:Mobile/role/screen/role_add_update.dart';
import 'package:Mobile/role/screen/role_details.dart';
import 'package:Mobile/role/screen/role_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RoleList extends StatelessWidget {
  static const routeName = '/roles';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Medias'),
      ),
      body: BlocBuilder<RoleBloc, RoleState>(
        builder: (_, state) {
          if(state is RoleOperationFailure){
            return Text('Not able to display List of Roles');
          }
          if(state is RoleLoadSuccess) {
            final medias = state.role;
            return ListView.builder(
                itemCount: medias.length,
                itemBuilder: (_, index) => ListTile(
                  title: Text('${medias[index].name}'),
                  onTap: () => Navigator.of(context).pushNamed(RoleDetails.routeName, arguments: medias[index]),
                ));
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AddUpdateRole.routeName, arguments: RoleArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
