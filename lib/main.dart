import 'package:Mobile/bloc_observer.dart';
import 'package:Mobile/media/media.dart';
import 'package:Mobile/media/screens/media_route.dart';
import 'package:Mobile/post/post.dart';
import 'package:Mobile/post/screens/post_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final MediaRepository mediaRepository = MediaRepository(dataProvider: MediaDataProvider(httpClient: http.Client()));
  // final PostRepository postRepository = PostRepository(
  //   dataProvider: PostDataProvider(
  //     httpClient: http.Client(),
  //   ),
  // );
  runApp(MyApp(mediaRepository: mediaRepository));
}

class MyApp extends StatelessWidget{
  final MediaRepository mediaRepository;
  MyApp({@required this.mediaRepository}) : assert(mediaRepository != null);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(value: this.mediaRepository,
      child: BlocProvider(
        create: (context) => MediaBloc(mediaRepository: this.mediaRepository)..add(MediaLoad()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity
          ),
          onGenerateRoute: MediaAppRoute.generateRoute ,
        ),
      ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   final PostRepository postRepository;
//   MyApp({@required this.postRepository}) : assert(postRepository != null);
//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: this.postRepository,
//       child: BlocProvider(
//         create: (context) => PostBloc(postRepository: this.postRepository)..add(PostLoad()),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             visualDensity: VisualDensity.adaptivePlatformDensity
//           ),
//           onGenerateRoute: PostAppRoute.generateRoute,
//         ),
//       ),
//     );
//   }
// }
