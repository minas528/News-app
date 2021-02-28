import 'package:Mobile/users/model/User.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class AppLoaded extends AuthEvent {}


class UserLoggedIn extends AuthEvent {
  final User user;

  UserLoggedIn({@required this.user});
  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthEvent {}
