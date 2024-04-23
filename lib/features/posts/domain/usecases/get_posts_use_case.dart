import 'package:dartz/dartz.dart';
import 'package:postsappcleanarch/features/posts/domain/repositories/posts_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/posts_entity.dart';

class GetPostsUseCase {

   PostsRepository postsRepository ;

   GetPostsUseCase ({required this.postsRepository});
  Future <Either<Failure , List<PostsEntity>>> callAllPosts () async {
    return postsRepository.getAllPosts();
  }

}