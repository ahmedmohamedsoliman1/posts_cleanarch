import 'package:postsappcleanarch/core/errors/failure.dart';
import 'package:postsappcleanarch/features/posts/domain/entities/posts_entity.dart';
import "package:dartz/dartz.dart" ;

abstract class PostsRepository {

  Future <Either<Failure , List<PostsEntity>>> getAllPosts () ;

}