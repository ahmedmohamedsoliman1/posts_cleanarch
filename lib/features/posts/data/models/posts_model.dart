import 'package:postsappcleanarch/features/posts/domain/entities/posts_entity.dart';

class PostsModel extends PostsEntity{
  PostsModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body});

 PostsModel.fromJson (Map<String , dynamic> json){
   userId = json["userId"];
   id = json["id"];
   title = json["title"];
   body = json["body"];
}

 Map <String , dynamic> tojson () {
   return {
     "id" : id ,
     "userId" : userId ,
     'title' : title ,
     "body" : body
   };
 }
}