import 'package:academic_app/screens/list_atividades.dart';
import 'package:academic_app/screens/list_videos.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(),
      body: buildPages(),
    );
  }

  Widget buildBottomBar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Atividades',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection_outlined),
          label: 'Videos',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return const ListagemAtividades();
      case 1:
        return const ListVideos();
      default:
        return Container();
    }
  }
}
