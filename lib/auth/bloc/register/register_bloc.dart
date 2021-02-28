
import 'package:Mobile/auth/bloc/auth_bloc.dart';
import 'package:Mobile/auth/bloc/register/register.dart';
import 'package:Mobile/auth/bloc/register/register_state.dart';
import 'package:Mobile/auth/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthBloc authenticationBloc;
  final AuthRepository authenticationRepository;

  RegisterBloc({this.authenticationBloc, this.authenticationRepository})
      : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterUser) {
      yield* _mapSeekerRegisterWithEmailToState(event);
    }
  }

  Stream<RegisterState> _mapSeekerRegisterWithEmailToState(
      RegisterUser event) async* {
    yield RegisterLoading();
    try {
      final bool isCreated = await authenticationRepository.register(user: event.user);
      print("logged in user $isCreated");

      if (isCreated) {
        yield RegisterSuccess();
        yield RegisterInitial();
      } else {
        yield RegisterFailure(error: 'Something very weird just happened');
      }
    }  catch (e) {
      yield RegisterFailure(error: e.message);
    }
  }
}
