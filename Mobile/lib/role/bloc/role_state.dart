
import 'package:Mobile/role/model/models.dar.dart';
import 'package:equatable/equatable.dart';

class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}
class RoleLoading extends RoleState{}

class RoleLoadSuccess extends RoleState {
  final List<Role> role;

  RoleLoadSuccess([this.role = const[]]);

  @override
  List<Object> get props => [role];
}

class RoleOperationFailure extends RoleState {}

