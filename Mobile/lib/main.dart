import 'package:Mobile/auth/bloc/auth_bloc.dart';
import 'package:Mobile/auth/bloc/auth_event.dart';
import 'package:Mobile/auth/bloc/login/login_bloc.dart';
import 'package:Mobile/auth/bloc/login/login_state.dart';
import 'package:Mobile/auth/bloc/register/register.dart';
import 'package:Mobile/auth/data_provider/auth_data.dart';
import 'package:Mobile/auth/repository/auth_repository.dart';
import 'package:Mobile/bloc_observer.dart';
import 'package:Mobile/news/post.dart';
import 'package:Mobile/routes.dart';
import 'package:Mobile/users/data_provider/data_provider.dart';
import 'package:Mobile/users/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  Bloc.observer = SimpleBlocObserver();
  final AuthRepository authRepository = AuthRepository(authDataProvider: AuthDataProvider(httpClient: http.Client()));
  // final MediaRepository mediaRepository = MediaRepository(dataProvider: MediaDataProvider(httpClient: http.Client()));
  final UsesrRepository usesrRepository = UsesrRepository(dataProvider: UserDataProvider(httpClient: http.Client()));
  final PostRepository postRepository = PostRepository(
    dataProvider: PostDataProvider(
      httpClient: http.Client(),
    ),
  );
  // runApp(MyApp( userRepository: usesrRepository ,));
  // runApp(MyApp(postRepository: postRepository));
  runApp(MyApp(authRepository: authRepository,));
}

class MyApp extends StatelessWidget{
  final AuthRepository authRepository;
  const MyApp({Key key, this.authRepository}) :assert(authRepository != null);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: this.authRepository)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(this.authRepository)..add(AppLoaded()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authenticationBloc: AuthBloc(authRepository)),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(
              authenticationBloc: AuthBloc(authRepository),
              authenticationRepository: this.authRepository
            ),
          )
        ],
        child: MaterialApp(
          title: 'Top News',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: PageRouter.onGenerateRoute,
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget{
//   final UsesrRepository userRepository;
//   MyApp({@required this.userRepository}) : assert(userRepository != null);
//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(value: this.userRepository,
//       child: BlocProvider(
//         create: (context) => UserBloc(usesrRepository: this.userRepository)..add(UserLoad()),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//               primarySwatch: Colors.blueGrey,
//               visualDensity: VisualDensity.adaptivePlatformDensity
//           ),
//           onGenerateRoute: UserAppRoute.generateRoute ,
//         ),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget{
//   final MediaRepository mediaRepository;
//   MyApp({@required this.mediaRepository}) : assert(mediaRepository != null);
//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(value: this.mediaRepository,
//       child: BlocProvider(
//         create: (context) => MediaBloc(mediaRepository: this.mediaRepository)..add(MediaLoad()),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             primarySwatch: Colors.blueGrey,
//             visualDensity: VisualDensity.adaptivePlatformDensity
//           ),
//           onGenerateRoute: MediaAppRoute.generateRoute ,
//         ),
//       ),
//     );
//   }
// }
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
//           // home: Home(),
//           onGenerateRoute: PostAppRoute.generateRoute,
//         ),
//       ),
//     );
//   }
// }
