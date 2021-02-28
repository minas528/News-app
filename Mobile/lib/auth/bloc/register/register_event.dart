import 'package:Mobile/users/model/User.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterUser extends RegisterEvent {
  final User user;


  RegisterUser({@required this.user});

  @override
  List<Object> get props => [user];
}
