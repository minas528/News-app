import 'package:Mobile/post/bloc/bloc.dart';
import 'package:Mobile/post/post.dart';
import 'package:Mobile/post/repository/post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({@required this.postRepository})
    : assert(postRepository != null),
      super(PostLoading());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async*{
    if (event is PostLoad) {
      yield PostLoading();
      try {
        final posts = await postRepository.getPosts();

        yield PostLoadSuccess(posts);
      }catch(_) {
        yield PostOperationFailure();
      }
    }
    if (event is PostCreate) {
      try {
        await postRepository.createPost(event.post);
        final posts = await postRepository.getPosts();
        print(posts);
        yield PostLoadSuccess(posts);
      } catch (err) {
        yield PostOperationFailure();
      }
    }
    if (event is PostUpdate) {
      try {
        await postRepository.updatePost(event.post);
        print('bfore');
        final posts = await postRepository.getPosts();
        print(posts);
        print('cook');
        yield PostLoadSuccess(posts);
      } catch (err) {
        print('err');
        yield PostOperationFailure();
      }
    }

    if (event is PostDelete) {
      try {
        await postRepository.deletePost(event.post.id);
        final posts = await postRepository.getPosts();
        yield PostLoadSuccess(posts);
      } catch (err) {
        yield PostOperationFailure();
      }
    }
  }
}