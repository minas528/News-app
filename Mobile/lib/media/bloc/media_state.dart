import 'package:Mobile/post/post.dart';
import 'package:equatable/equatable.dart';

class MediaState extends Equatable {
  const MediaState();

  @override
  List<Object> get props => [];
}
class MediaLoading extends MediaState{}

class MediaLoadSuccess extends MediaState {
  final List<Media> media;

  MediaLoadSuccess([this.media = const[]]);

  @override
  List<Object> get props => [media];
}

class MediaOperationFailure extends MediaState {}

