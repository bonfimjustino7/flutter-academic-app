import 'dart:async';

import 'package:academic_app/models/video.dart';
import 'package:academic_app/screens/player.dart';
import 'package:academic_app/services/video_api.dart';
import 'package:academic_app/shared/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListVideos extends StatefulWidget {
  const ListVideos({Key? key}) : super(key: key);

  @override
  State<ListVideos> createState() => _ListVideosState();
}

class _ListVideosState extends State<ListVideos> {
  List<Video> listagemVideos = <Video>[];
  bool _isLoading = false;
  bool _showFab = false;
  int _pageCurrent = 1;
  int _totalResults = 0;
  final ScrollController _scrollController = ScrollController();

  Future fetchVideos({int? page}) async {
    int newPage = page ?? 1;

    var response = await VideoApi.request(
        {'query': 'tecnology', 'page': newPage.toString()});

    _totalResults = response['total_results'];
    _pageCurrent = response['page'];

    return response;
  }

  void getVideos({bool? lazy}) async {
    try {
      if (lazy != null) {
        if (_totalResults > listagemVideos.length) {
          _pageCurrent += 1;

          var newValues = await fetchVideos(page: _pageCurrent);

          setState(() {
            var newValuesList = VideoApi.getVideos(newValues);
            listagemVideos.addAll(newValuesList);
          });
        }
      } else {
        setState(() {
          _isLoading = true;
        });

        var response = await fetchVideos();

        setState(() {
          listagemVideos = VideoApi.getVideos(response);
          _isLoading = false;
        });
      }
    } catch (e) {
      _showMyDialog(e.toString());
      setState(() {
        _isLoading = false;
      });
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

  Widget buildList() {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final ScrollDirection direction = notification.direction;
        final metrics = notification.metrics;

        setState(() {
          if (direction == ScrollDirection.reverse) {
            _showFab = false;
          } else if (direction == ScrollDirection.forward) {
            _showFab = true;
          }

          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              setState(() {
                Timer(
                  const Duration(seconds: 1),
                  () => setState(() {
                    _showFab = false;
                  }),
                );
              });
            } else {
              getVideos(lazy: true);
            }
          }
        });

        return true;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8.0),
        itemCount: listagemVideos.length,
        itemBuilder: (context, index) {
          Video video = listagemVideos[index];

          if (index == listagemVideos.length - 1 &&
              _totalResults > listagemVideos.length) {
            return const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos Adicionados'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
        ),
        child: !_isLoading
            ? buildList()
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ),
      ),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _showFab ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
              tooltip: 'Ir para o topo',
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease);
                setState(() {
                  Timer(
                    const Duration(seconds: 1),
                    () => setState(() {
                      _showFab = false;
                    }),
                  );
                });
              },
              child: const Icon(Icons.arrow_upward_rounded)),
        ),
      ),
    );
  }
}
