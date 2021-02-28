
import 'package:Mobile/auth/bloc/auth_bloc.dart';
import 'package:Mobile/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_event.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authenticationBloc;
  final AuthRepository authenticationRepository;

  LoginBloc({this.authenticationBloc, this.authenticationRepository})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    print(" is userr data");

    try {
      final user = await authenticationRepository.logIn(
          username: event.username, password: event.password);
      print("logged in user $user");
      if (user != null) {
        authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    }  catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
