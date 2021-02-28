import 'package:Mobile/post/bloc/bloc.dart';
import 'package:Mobile/post/model/catagories_model.dart';
import 'package:Mobile/post/screens/post_add_update.dart';
import 'package:Mobile/post/screens/post_route.dart';
import 'package:Mobile/reusable/custom_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatefulWidget {
  static const routeName = '//';
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: catagories.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
  }

  _smoothScrollToTop() {
    if (_scrollController.hasClients)
      _scrollController.animateTo(
        0,
        duration: Duration(microseconds: 300),
        curve: Curves.ease,
      );
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        shadowColor: Colors.yellow,
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: IconButton(
                icon: Icon(Icons.refresh),
                color: Colors.deepPurpleAccent,
                onPressed: () =>
                    Navigator.of(context).pushNamed(PostList.routeName)),
          )
        ],
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top News Updates",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Times",
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.centerLeft,
                child: TabBar(
                    labelPadding: EdgeInsets.only(right: 15),
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(),
                    labelColor: Colors.black,
                    labelStyle: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.black45,
                    unselectedLabelStyle: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                    tabs: List.generate(catagories.length,
                        (index) => Text(catagories[index].name))),
              ),
            ),
          ];
        },
        body: Container(
          child: Scaffold(
            body: BlocBuilder<PostBloc, PostState>(builder: (_, state) {
              if (state is PostOperationFailure) {
                return Center(child: Text('not able to load'));
              }
              if (state is PostLoadSuccess) {
                final posts = state.posts;
                // print(posts);
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (_, index) => HomePageCard(
                    posts: posts[index],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: () => Navigator.of(context).pushNamed(
                  AddUpdatePost.routeName,
                  arguments: PostArguments(edit: false)),
              child: Icon(Icons.add),
            ),

          ),
        ),
      ),
    ));
  }
}
