import 'package:Mobile/role/model/models.dar.dart';
import 'package:equatable/equatable.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();
}

class RoleLoad extends RoleEvent {
  const RoleLoad();

  @override
  List<Object> get props => [];
}

class LoadSingleRole extends RoleEvent {
  final Role role;
  LoadSingleRole(this.role);

  @override
  List<Object> get props => [role];

  @override
  String toString() {
    return 'Role feached {media: $role}';
  }
}

class RoleCreate extends RoleEvent {
  final Role role;

  const RoleCreate(this.role);

  @override
  List<Object> get props => [role];

  @override
  String toString() => 'Role Created {role : $role';
}


class RoleUpdate extends RoleEvent {
  final Role role;
  const RoleUpdate(this.role);

  @override
  List<Object> get props => [role];
  @override
  String toString() => 'Role Updated {media : $role';
}

class RoleDelete extends RoleEvent {
  final Role role;
  const RoleDelete(this.role);

  @override
  List<Object> get props => [role];

  @override
  String toString() => 'Media Deleted {media : $role';
}
