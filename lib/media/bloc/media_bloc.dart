
import 'package:Mobile/media/bloc/media_event.dart';
import 'package:Mobile/media/bloc/media_state.dart';
import 'package:Mobile/media/repository/media_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaRepository mediaRepository;

  MediaBloc({@required this.mediaRepository})
      : assert(mediaRepository != null),
        super(MediaLoading());

  @override
  Stream<MediaState> mapEventToState(MediaEvent event) async*{
    if (event is MediaLoad) {
      yield MediaLoading();
      try {
        final media = await mediaRepository.getMedias();

        yield MediaLoadSuccess(media);
      }catch(_) {
        yield MediaOperationFailure();
      }
    }
    if( event is LoadSingleMedia){
      yield MediaLoading();
      try{
        final media = await mediaRepository.getMediaById(event.media.id);
        yield MediaLoadSuccess();
      } catch(_){
        yield MediaOperationFailure();
      }
    }
    if (event is MediaCreate) {
      try {
        await mediaRepository.createMedia(event.media);
        final medias = await mediaRepository.getMedias();
        print(medias);
        yield MediaLoadSuccess(medias);
      } catch (err) {
        yield MediaOperationFailure();
      }
    }
    if (event is MediaUpdate) {
      try {
        await mediaRepository.updateMedia(event.media);
        print('before');
        final medias = await mediaRepository.getMedias();
        print(medias);
        yield MediaLoadSuccess(medias);
      } catch (err) {
        print('err');
        yield MediaOperationFailure();
      }
    }

    if (event is MediaDelete) {
      try {
        await mediaRepository.deleteMedia(event.media.id);
        final posts = await mediaRepository.getMedias();
        yield MediaLoadSuccess(posts);
      } catch (err) {
        yield MediaOperationFailure();
      }
    }
  }
}