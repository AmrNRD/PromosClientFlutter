
import 'dart:convert';

import 'package:PromoMeFlutter/data/models/post_model.dart';

import '../../main.dart';
import '../models/user_model.dart';
import '../sources/remote/base/api_caller.dart';
import '../sources/remote/base/app.exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class PostRepository {

  Future<List<Post>> getProfilePosts();

  Future<Post> addPost(Post post);

}

class PostDataRepository implements PostRepository {
  @override
  Future<List<Post>> getProfilePosts() async {
    final responseData = await APICaller.getData("/posts",authorizedHeader: true);
    List<Post>posts=[];
    for(var postData in responseData['data'])
    {
      posts.add(Post.fromJson(postData));
    }
    return posts;
  }

  @override
  Future<Post> addPost(Post post) async {
    final responseData = await APICaller.getData("/profile-posts");
    Post post=Post.fromJson(responseData);
    return post;
  }

}
