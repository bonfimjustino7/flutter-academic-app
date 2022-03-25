import 'dart:async';

import 'package:academic_app/models/video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeVideoPlayer extends StatefulWidget {
  const HomeVideoPlayer({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  State<HomeVideoPlayer> createState() => _HomeVideoPlayerState();
}

class _HomeVideoPlayerState extends State<HomeVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.video.url);

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.video.user.nome;

    return Scaffold(
        appBar: AppBar(
          title: Text('Make by $title'),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.deepPurple[100]),
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    SizedBox.expand(
                      child: FittedBox(
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: Stack(
                            children: [
                              VideoPlayer(_controller),
                              Positioned(
                                bottom: 0,
                                width: _controller.value.size.width,
                                height: 15,
                                child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: false,
                                  colors: const VideoProgressColors(
                                    backgroundColor: Colors.blueGrey,
                                    bufferedColor: Colors.blueGrey,
                                    playedColor: Colors.deepPurple,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
