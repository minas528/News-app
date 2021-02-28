import 'package:Mobile/users/bloc/user_event.dart';
import 'package:Mobile/users/bloc/user_state.dart';
import 'package:Mobile/users/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsesrRepository usesrRepository;

  UserBloc({@required this.usesrRepository})
      : assert(usesrRepository != null),
        super(UserLoading());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{
    if (event is UserLoad) {
      yield UserLoading();
      try {
        final user = await usesrRepository.getUsers();

        yield UserLoadSuccess(user);
      }catch(_) {
        yield UserOperationFailure();
      }
    }
    if( event is LoadSingleUser){
      yield UserLoading();
      try{
        final user = await usesrRepository.getUserById(event.user.id);
        yield UserLoadSuccess();
      } catch(_){
        yield UserOperationFailure();
      }
    }
    if (event is UserCreate) {
      try {
        await usesrRepository.createUser(event.user);
        final users = await usesrRepository.getUsers();
        print(users);
        yield UserLoadSuccess(users);
      } catch (err) {
        yield UserOperationFailure();
      }
    }
    if (event is UserUpdate) {
      try {
        await usesrRepository.updateUser(event.user);
        print('before');
        final medias = await usesrRepository.getUsers();
        print(medias);
        yield UserLoadSuccess(medias);
      } catch (err) {
        print('err');
        yield UserOperationFailure();
      }
    }

    if (event is UserDelete) {
      try {
        await usesrRepository.deleteUser(event.user.id);
        final users = await usesrRepository.getUsers();
        yield UserLoadSuccess(users);
      } catch (err) {
        yield UserOperationFailure();
      }
    }
  }
}