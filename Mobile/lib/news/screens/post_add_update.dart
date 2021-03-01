import 'dart:io';

import 'package:Mobile/news/screens/post_detail.dart';
import 'package:Mobile/news/screens/post_list.dart';
import 'package:Mobile/news/screens/post_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Mobile/news/post.dart';
import 'package:image_picker/image_picker.dart';

class AddUpdatePost extends StatefulWidget {
  static const routeName = 'postAddUpdate';
  final PostArguments args;

  AddUpdatePost({this.args});

  @override
  _AddUpdatePostState createState() => _AddUpdatePostState();
}

class _AddUpdatePostState extends State<AddUpdatePost> {
  final _formKeyMedia = GlobalKey<FormState>();
  final Map<String, dynamic> _post = {};
  File _imageFile;

  _onImageButtonPressed() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    print(image);
    setState(() {
      _imageFile = image;
    });
  }



    @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.args.edit ? "Edit Post" : "Add New Post", style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKeyMedia,
          child: Column(
            children: [
              TextFormField(
                initialValue:
                    widget.args.edit ? widget.args.post.headLines : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter post headline';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'headlines'),
                onSaved: (value) {
                  setState(() {
                    this._post["headlines"] = value;
                  });
                },
              ),
              TextFormField(
                initialValue: widget.args.edit ? widget.args.post.content : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter post content';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Content'),
                onSaved: (value) {
                  setState(() {
                    this._post["content"] = value;
                  });
                },
              ),
              TextFormField(
                initialValue: widget.args.edit ? widget.args.post.media : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Media';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'media'),
                onSaved: (value) {
                  setState(() {
                    this._post["media"] = value;
                  });
                },
              ),

              TextFormField(
                initialValue: widget.args.edit ? widget.args.post.reporter : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter reporter';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'reporter'),
                onSaved: (value) {
                  setState(() {
                    this._post["reporter"] = value;
                  });
                },
              ),
              RaisedButton(onPressed: () async {
                await _onImageButtonPressed();
                print(_imageFile);
                this._post["image"] = _imageFile;
              },
              child: Text("Choose Image"),),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   child: FlatButton(
              //     child: Icon(
              //       Icons.camera_alt,
              //     ),
              //     onPressed: (){},
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                    onPressed: () {
                      final form = _formKeyMedia.currentState;
                      if (form.validate()) {
                        form.save();
                        final PostEvent event = widget.args.edit
                            ? PostUpdate(
                                Post(
                                  id: widget.args.post.id,
                                  headLines: this._post['headlines'],
                                  content: this._post['content'],
                                  image: this._post['image'],
                                  imgUrl: widget.args.post.imgUrl,
                                  media: '6026dffda23ef64e486edbb2',
                                  reporter: '6026e2736efc8353fee595f4',
                                ),
                              )
                            : PostCreate(
                                Post(
                                  headLines: this._post['headlines'],
                                  content: this._post['content'],
                                  image: this._post['image'],
                                  media: '6026dffda23ef64e486edbb2',
                                  reporter: '6026e2736efc8353fee595f4',
                                ),
                              );
                        BlocProvider.of<PostBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            PostList.routeName, (route) => false);
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text('SAVE'),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
