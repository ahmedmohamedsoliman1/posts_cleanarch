import 'package:postsappcleanarch/core/databases/api/api_consumer.dart';
import 'package:postsappcleanarch/core/databases/api/end_points.dart';
import 'package:postsappcleanarch/features/posts/data/models/posts_model.dart';

class RemotePostsDataSource {

  ApiConsumer api ;
  RemotePostsDataSource ({required this.api});

  Future <List<PostsModel>> getAllPosts () async {
    var response = await api.get(EndPoints.post);
    return (response as List).map((e) => PostsModel.fromJson(e)).toList();
  }
}