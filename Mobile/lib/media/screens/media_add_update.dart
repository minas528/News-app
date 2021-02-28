
import 'package:Mobile/media/bloc/bloc.dart';
import 'package:Mobile/media/media.dart';
import 'package:Mobile/media/screens/media_list.dart';
import 'package:Mobile/media/screens/media_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateMedia extends StatefulWidget {
  static const routeName = 'mediaAddUpdate';
  final MediaArgument args;

  AddUpdateMedia({this.args});
  @override
  _AddUpdateMediaState createState() => _AddUpdateMediaState();
}

class _AddUpdateMediaState extends State<AddUpdateMedia> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _media = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.edit ? 'Edit Media' : 'Create Media'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.args.edit ? widget.args.media.name : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Media Name';
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
              TextFormField(
                initialValue: widget.args.edit ? widget.args.media.email : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Media Email';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'email'),
                onSaved: (value) {
                  setState(() {
                    this._media["email"] = value;
                  });
                },
              ),
              TextFormField(
                initialValue: widget.args.edit ? widget.args.media.website : '',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Media website';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'website'),
                onSaved: (value) {
                  setState(() {
                    this._media["website"] = value;
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
                        final MediaEvent event = widget.args.edit
                            ? MediaUpdate(
                                Media(
                                  id: widget.args.media.id,
                                  name: this._media['name'],
                                  email: this._media['email'],
                                  website: this._media['website'],
                                ),
                              )
                            : MediaCreate(Media(
                                name: this._media['name'],
                                email: this._media['email'],
                                website: this._media['website'],
                              ));
                        BlocProvider.of<MediaBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            MediaList.routeName, (route) => false);
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
