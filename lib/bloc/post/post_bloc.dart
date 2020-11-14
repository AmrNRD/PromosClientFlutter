import 'dart:async';

import 'package:PromoMeFlutter/data/models/post_model.dart';
import 'package:PromoMeFlutter/data/repositories/post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this.postRepository) : super(PostInitial());
  final PostRepository postRepository;

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    try {
      yield PostLoading();
      if (event is GetAllPastsEvent) {
        List<Post>posts=await postRepository.getProfilePosts();
        yield PostsLoaded(posts);
      }
    } catch (error) {
      yield PostError(error.toString());
    }
  }
}
