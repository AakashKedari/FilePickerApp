

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';


class SavedVideosPage extends StatefulWidget {
  const SavedVideosPage({super.key});
  @override
  State<SavedVideosPage> createState() => _SavedVideosPageState();
}


class _SavedVideosPageState extends State<SavedVideosPage> {
  List<dynamic> fetchVideosPath = [];
  List<VideoPlayerController> videoControllers = [];

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    if (box.read('VideosPath') != 'Not Assigned') {
      fetchVideosPath = box.read('VideosPath');
      initialiseVideoControllers();
    }
    print(fetchVideosPath);
  }

  void initialiseVideoControllers() {
    for (String videoPath in fetchVideosPath) {
      File file = File(videoPath);
      VideoPlayerController controller = VideoPlayerController.file(file);
      controller.initialize().then((_) {
        setState(() {}); // Update the state after initialization
      });
      videoControllers.add(controller);
    }
  }

  @override
  void dispose() {
    for (VideoPlayerController controller in videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        for (VideoPlayerController controller in videoControllers) {
          controller.dispose();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Saved Videos'),
        ),
        body: fetchVideosPath.isEmpty
            ? Center(child: Text('Nothing Saved'))
            : InkWell(
          onTap: () {
            for (VideoPlayerController controller in videoControllers) {
              controller.pause();
            }
          },
          onDoubleTap: () {
            for (VideoPlayerController controller in videoControllers) {
              controller.play();
            }
          },

          child: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: videoControllers.length,
            itemBuilder: (context, index) {
              return VideoPlayer(videoControllers[index]);
            },
          ),
        ),
      ),
    );
  }
}
