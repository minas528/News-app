import 'package:Mobile/media/screens/media_list.dart';
import 'package:Mobile/media/screens/media_route.dart';
import 'package:Mobile/post/screens/post_add_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../media.dart';

class MediaDetails extends StatelessWidget {
  static const routeName = 'mediaDetails';
  final Media media;
  MediaDetails({this.media});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.media.name),
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Name: ${this.media.name}'),
              subtitle: Text('Email: ${this.media.email}'),
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
            Text(this.media.website),
            Padding(
              padding: const EdgeInsets.all(55.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child:Icon(Icons.edit),
                      onPressed: () => Navigator.of(context).pushNamed(
                        AddUpdatePost.routeName,
                        arguments: MediaArgument(media: this.media, edit: true),
                      ),
                    ),
                    RaisedButton(
                      child: Icon(Icons.delete),
                        onPressed: () {
                      context.read<MediaBloc>().add(MediaDelete(this.media));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MediaList.routeName, (route) => false);
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
