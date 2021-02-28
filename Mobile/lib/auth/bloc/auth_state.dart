import 'package:Mobile/users/model/User.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthState {}

class AuthenticationLoading extends AuthState {}

class AuthenticationNotAuthenticated extends AuthState {}

class AuthenticationAuthenticated extends AuthState {
  final User user;
  AuthenticationAuthenticated({@required this.user});
  @override
  List<Object> get props => [user];

}

class AuthenticationFailure extends AuthState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}