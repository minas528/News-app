
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
      :assert(authenticationRepository!=null) ,super(LoginInitial()) ;

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
      print('even herer'+event.username+ event.password);
      print(authenticationRepository==null);
      final user = await authenticationRepository.logIn(
          username: event.username,
          password: event.password);
      print("logged in user $user");
      if (user != null) {

        authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        print('blocked errrrrrrr');
        yield LoginFailure(error: 'Something very weird just happened');
      }
    }  catch (err) {
      print('err'+err.toString());
      yield LoginFailure(error: 'An unknown error occured');
    }
  }
}
