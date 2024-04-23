

import 'package:flutter/material.dart';
import 'package:postsappcleanarch/core/databases/cache/cache_helper.dart';
import 'package:postsappcleanarch/features/posts/presentation/provider/posts_provider.dart';
import 'package:provider/provider.dart';

import 'features/posts/presentation/pages/posts_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
      ChangeNotifierProvider(
      create: (context) => PostsProvider() ,
      child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: PostsScreen()
    );
  }
}
