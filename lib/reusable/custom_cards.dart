import 'package:Mobile/post/post.dart';
import 'package:Mobile/post/screens/post_detail.dart';
import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  final Post posts ;
  final String imageUrl = 'http://10.0.2.2:5000/files/2021-02-15T07:39:25.597Zmojave_dynamic_2.jpeg';
  final time = "07 May  07:19";
  const HomePageCard({this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: ()=>Navigator.of(context).pushNamed(PostDetail.routeName, arguments: posts),
            child: Container(
              height: 203,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xff707070),
                  width: 1,
                ),
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.fill),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: Colors.black.withOpacity(0.33),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Center(
                        child: Text(
                          this.posts.headLines,
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 16,
                              color: Colors.white),
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(posts.createdAt.substring(0,10),
              style: TextStyle(
                  fontFamily: "Times", fontSize: 13, color: Color(0xff8a8989))),
          SizedBox(
            height: 7,
          ),
          Text(this.posts.content,
              style: TextStyle(
                  fontFamily: "League",
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
