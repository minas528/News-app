import 'package:Mobile/post/post.dart';
import 'package:Mobile/post/screens/post_add_update.dart';
import 'package:Mobile/post/screens/post_list.dart';
import 'package:Mobile/post/screens/post_route.dart';
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
      body: Card(
        child: Column(
          children: [
            // Padding(padding: EdgeInsets.all(10)),
            Image(
              image: NetworkImage(
                  'http://10.0.2.2:5000/files/2021-02-15T07:39:25.597Zmojave_dynamic_2.jpeg'),
              width: MediaQuery.of(context).size.width,
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
              height: 310,
              // margin: ,
              padding: EdgeInsets.all(10),
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
                  children: [
                    SizedBox(
                      width: 90,
                    ),
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
    );
  }
}
