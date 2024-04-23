import 'dart:developer';

import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:postsappcleanarch/core/databases/api/dio_consumer.dart';
import 'package:postsappcleanarch/core/databases/cache/cache_helper.dart';
import 'package:postsappcleanarch/core/errors/failure.dart';
import 'package:postsappcleanarch/features/posts/data/datasources/local_posts_data_source.dart';
import 'package:postsappcleanarch/features/posts/data/datasources/remote_posts_data_source.dart';
import 'package:postsappcleanarch/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:postsappcleanarch/features/posts/domain/entities/posts_entity.dart';
import '../../../../core/connection/network_info.dart';
import '../../domain/usecases/get_posts_use_case.dart';

class PostsProvider extends ChangeNotifier {
  List<PostsEntity> allPostsList = [] ;

  bool isAllPostsLoading = false ;

  void getAllPosts () async{
    isAllPostsLoading = true ;
    var allPosts = await GetPostsUseCase(
        postsRepository: PostsRepositoryImpl(
            networkInfo: NetworkInfoImpl(DataConnectionChecker()),
            remotePostsDataSource: RemotePostsDataSource(api: DioConsumer(dio: Dio())),
            localPostsDataSource: LocalPostsDataSource(cacheHelper: CacheHelper()
            )
        )
    ).callAllPosts();

    allPosts.fold(
            (failure) => Failure(errMessage: failure.errMessage),
            (posts) => allPostsList = posts);
    isAllPostsLoading = false ;
    log("loaaaaading : ${isAllPostsLoading.toString()}");
    notifyListeners();
  }
}