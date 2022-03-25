import 'package:academic_app/screens/list_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const ListVideos(),
    );
  }
}
