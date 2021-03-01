
import 'package:Mobile/media/bloc/bloc.dart';
import 'package:Mobile/role/bloc/role_event.dart';
import 'package:Mobile/role/bloc/role_state.dart';
import 'package:Mobile/role/repository/repostory.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final RoleRepository roleRepository;

  RoleBloc({@required this.roleRepository})
      : assert(roleRepository != null),
        super(RoleLoading());

  @override
  Stream<RoleState> mapEventToState(RoleEvent event) async*{
    if (event is RoleLoad) {
      yield RoleLoading();
      try {
        final media = await roleRepository.getMedias();

        yield RoleLoadSuccess(media);
      }catch(_) {
        yield RoleOperationFailure();
      }
    }
    if( event is LoadSingleRole){
      yield RoleLoading();
      try{
        final media = await roleRepository.getMediaById(event.role.id);
        yield RoleLoadSuccess();
      } catch(_){
        yield RoleOperationFailure();
      }
    }
    if (event is RoleCreate) {
      try {
        await roleRepository.createMedia(event.role);
        final medias = await roleRepository.getMedias();
        print(medias);
        yield RoleLoadSuccess(medias);
      } catch (err) {
        yield RoleOperationFailure();
      }
    }
    if (event is RoleUpdate) {
      try {
        await roleRepository.updateMedia(event.role);
        print('before');
        final medias = await roleRepository.getMedias();
        print(medias);
        yield RoleLoadSuccess(medias);
      } catch (err) {
        print('err');
        yield RoleOperationFailure();
      }
    }

    if (event is RoleDelete) {
      try {
        await roleRepository.deleteMedia(event.role.id);
        final posts = await roleRepository.getMedias();
        yield RoleLoadSuccess(posts);
      } catch (err) {
        yield RoleOperationFailure();
      }
    }
  }
}