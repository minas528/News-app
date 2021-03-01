import 'package:Mobile/news/post.dart';
import 'package:Mobile/news/screens/post_add_update.dart';
import 'package:Mobile/news/screens/post_list.dart';
import 'package:Mobile/news/screens/post_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetail extends StatelessWidget {
  static const routeName = 'postDetail';
  final Post post;

  PostDetail({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('${this.post.headLines}', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              // Padding(padding: EdgeInsets.all(10)),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image(
                  image: NetworkImage(
                      'http://10.6.223.96:5000/${this.post.imgUrl}'),
                  fit: BoxFit.fill,
                ),
              ),
              Card(
                borderOnForeground: true,
                elevation: 20,
                shadowColor: Colors.black,
                child: ListTile(
                  title: Text(post.headLines,style: TextStyle(
                    fontFamily: "Times", fontSize: 33, color: Colors.black,fontWeight: FontWeight.bold
                  )),
                  subtitle:Text( post.createdAt.substring(0,10), style: TextStyle(
                    fontFamily: "Times", fontSize: 13, color: Color(0xff8a8989)),),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                // height: 310,
                
                // margin: ,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                child: Text(this.post.content,
                    style: TextStyle(
                        fontFamily: "League",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                    ))),

              Center(
                child: Container(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pushNamed(
                          AddUpdatePost.routeName,
                          arguments: PostArguments(post: this.post, edit: true),
                        ),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
                        icon: Icon(Icons.edit),
                        label: Text('Edit'),

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<PostBloc>().add(PostDelete(this.post));
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              PostList.routeName, (route) => false);
                        },
                        icon: Icon(Icons.delete),
                        label: Text('Delete'),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red))
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
