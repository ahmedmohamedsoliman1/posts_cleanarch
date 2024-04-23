import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postsappcleanarch/features/posts/presentation/provider/posts_provider.dart';
import 'package:provider/provider.dart';

class PostsScreen extends StatefulWidget {

  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  loadData () {
    context.read<PostsProvider>().getAllPosts();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Consumer<PostsProvider>(
        builder: (context , provider , _) {
          if(provider.isAllPostsLoading){
            log("loading");
            log("loading : ${provider.isAllPostsLoading.toString()}");
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(),
            ));
          }else if (provider.allPostsList.isEmpty){
            log(provider.allPostsList.toString());
            return const Scaffold(
              body: Center(child: Text("Empty" , style: TextStyle(
                  color: Colors.black
              ),),),
            );
          }else {
            log("data");
            return Scaffold(
              body: ListView.separated(
                  itemBuilder: (context , index) => Text(
                    provider.allPostsList[index].title! ,
                    style: const TextStyle(
                        color: Colors.black
                    ),
                  ),
                  separatorBuilder: (context , index) => const SizedBox(height: 10,),
                  itemCount: provider.allPostsList.length),
            );
          }
        },);
  }
}