import 'package:Mobile/auth/bloc/auth_event.dart';
import 'package:Mobile/auth/bloc/auth_state.dart';
import 'package:Mobile/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authenticationRepository;

  AuthBloc(AuthRepository authenticationRepository)
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial());

  Stream<AuthState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      await Future.delayed(Duration(milliseconds: 500));
      print('what about here');
      final currentUser = await _authenticationRepository.getCurrentUser();
      print('currentUser'+ currentUser.toString());
      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: 'An unknown error occurred');
    }
  }

  Stream<AuthState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    _authenticationRepository.logOut();
    yield AuthenticationNotAuthenticated();
  }

  @override
  Stream<AuthState> mapEventToState(
      AuthEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }
    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }
}