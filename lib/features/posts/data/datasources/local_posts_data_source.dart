import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:postsappcleanarch/core/databases/cache/cache_helper.dart';
import 'package:postsappcleanarch/core/errors/exceptions.dart';

import '../models/posts_model.dart';

class LocalPostsDataSource {

  CacheHelper cacheHelper ;

  String key = "postsCached";

  LocalPostsDataSource ({required this.cacheHelper});

  savePostsList (List <PostsModel>? posts) {
    if (posts != null){
      List<String> postsEncoded = posts.map((post) => jsonEncode(post.tojson())).toList();
      cacheHelper.saveData(key: key, value: postsEncoded);
    }else {
      throw CacheExeption(errorMessage: "No internet connection");
    }
  }

  Future <List<PostsModel>> getAllCachedPosts () async {
    var cachedPosts =  cacheHelper.getListData(key: key);
    if (cachedPosts != null){
      List<PostsModel> posts = cachedPosts.map((e) => PostsModel.fromJson(jsonDecode(e))).toList();
      return Future.value(posts);
    }else {
      throw CacheExeption(errorMessage: "there is no cached posts");
    }
  }
}