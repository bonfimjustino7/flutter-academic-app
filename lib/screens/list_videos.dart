import 'dart:async';

import 'package:academic_app/models/video.dart';
import 'package:academic_app/screens/player.dart';
import 'package:academic_app/services/video_api.dart';
import 'package:academic_app/shared/widgets/card.dart';
import 'package:flutter/material.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({Key? key}) : super(key: key);

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {
  List<Video> listagemVideos = <Video>[];

  void getVideos() async {
    try {
      Iterable response = await VideoApi.getVideos({'query': 'people'});
      setState(() {
        listagemVideos =
            response.map((model) => Video.fromJson(model)).toList();
      });
    } catch (e) {
      _showMyDialog(e.toString());
    }
  }

  @override
  void initState() {
    getVideos();
    super.initState();
  }

  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error ao buscar dados'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tentar Novamente'),
              onPressed: () {
                Navigator.pop(context, true);
                Timer(const Duration(seconds: 1), () => getVideos());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos Adicionados'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.deepPurple[100]),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: listagemVideos.length,
          itemBuilder: (context, index) {
            Video video = listagemVideos[index];

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CardImage(
                  title: video.user.nome,
                  image: video.image,
                  onPressCard: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeVideoPlayer(
                          video: video,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
