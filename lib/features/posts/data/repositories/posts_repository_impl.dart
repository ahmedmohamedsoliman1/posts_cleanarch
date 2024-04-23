import 'package:dartz/dartz.dart';
import 'package:postsappcleanarch/core/connection/network_info.dart';
import 'package:postsappcleanarch/core/errors/exceptions.dart';
import 'package:postsappcleanarch/core/errors/failure.dart';
import 'package:postsappcleanarch/features/posts/domain/entities/posts_entity.dart';
import 'package:postsappcleanarch/features/posts/domain/repositories/posts_repository.dart';

import '../datasources/local_posts_data_source.dart';
import '../datasources/remote_posts_data_source.dart';

class PostsRepositoryImpl implements PostsRepository {

  NetworkInfo networkInfo ;
  LocalPostsDataSource localPostsDataSource ;
  RemotePostsDataSource remotePostsDataSource ;

  PostsRepositoryImpl ({required this.networkInfo ,
  required this.remotePostsDataSource ,
  required this.localPostsDataSource});

  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() async{
    if (await networkInfo.isConnected!){
     try {
       var response =  await remotePostsDataSource.getAllPosts();
       localPostsDataSource.savePostsList(response);
       return Right(response);
     }on ServerException catch (e){
       return Left(Failure(errMessage: e.errorModel.errorMessage));
     }

    }else {
     try {
       var response =  await localPostsDataSource.getAllCachedPosts();
       return Right(response);
     }on CacheExeption catch (e){
       return Left(Failure(errMessage: e.errorMessage));
     }
    }
  }


}