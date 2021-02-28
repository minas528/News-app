import 'package:Mobile/media/bloc/media_state.dart';
import 'package:Mobile/media/model/Media.dart';
import 'package:equatable/equatable.dart';

abstract class MediaEvent extends Equatable {
  const MediaEvent();
}

class MediaLoad extends MediaEvent {
  const MediaLoad();

  @override
  List<Object> get props => [];
}

class LoadSingleMedia extends MediaEvent {
  final Media media;
  LoadSingleMedia(this.media);

  @override
  List<Object> get props => [media];

  @override
  String toString() {
    return 'Media feached {media: $media}';
  }
}

class MediaCreate extends MediaEvent {
  final Media media;

  const MediaCreate(this.media);

  @override
  List<Object> get props => [media];

  @override
  String toString() => 'Media Created {media : $media';
}


class MediaUpdate extends MediaEvent {
  final Media media;
  const MediaUpdate(this.media);

  @override
  List<Object> get props => [media];
  @override
  String toString() => 'Media Updated {media : $media';
}

class MediaDelete extends MediaEvent {
  final Media media;
  const MediaDelete(this.media);

  @override
  List<Object> get props => [media];

  @override
  String toString() => 'Media Deleted {media : $media';
}
