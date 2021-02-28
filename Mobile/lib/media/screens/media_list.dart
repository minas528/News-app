import 'package:Mobile/media/bloc/bloc.dart';
import 'package:Mobile/media/screens/media_route.dart';
import 'package:Mobile/post/screens/post_add_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'media_details.dart';

class MediaList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Medias'),
      ),
      body: BlocBuilder<MediaBloc, MediaState>(
        builder: (_, state) {
          if(state is MediaOperationFailure){
            return Text('Not able to display List of Medias');
          }
          if(state is MediaLoadSuccess) {
            final medias = state.media;
            return ListView.builder(
              itemCount: medias.length,
                itemBuilder: (_, index) => ListTile(
              title: Text('${medias[index].name}'),
              subtitle: Text('${medias[index].email}'),
              onTap: () => Navigator.of(context).pushNamed(MediaDetails.routeName, arguments: medias[index]),
            ));
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AddUpdatePost.routeName, arguments: MediaArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
