import 'package:Mobile/auth/bloc/auth_event.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  const UserLoad();

  @override
  List<Object> get props => [];
}

class LoadSingleUser extends UserEvent {
  final User user;
  LoadSingleUser(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return 'User feached {media: $user}';
  }
}

class UserCreate extends UserEvent {
  final User user;

  const UserCreate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'user Created {media : $user';
}
// class LoginAuth extends UserEvent {
//   final Auth user;
//
//   const LoginAuth(this.user);
//
//   @override
//   List<Object> get props => [user];
//
//   @override
//   String toString() => 'user Created {media : $user';
// }


class UserUpdate extends UserEvent {
  final User user;
  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];
  @override
  String toString() => 'user Updated {media : $user';
}

class UserDelete extends UserEvent {
  final User user;
  const UserDelete(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Deleted {media : $user';
}
