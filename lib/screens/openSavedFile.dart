import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class OpenSavedFile extends StatefulWidget {
  String savedFilePath = '';
   OpenSavedFile({super.key,required this.savedFilePath});

  @override
  State<OpenSavedFile> createState() => _OpenSavedFileState();
}

class _OpenSavedFileState extends State<OpenSavedFile> {
  VideoPlayerController? videoPlayerController;

  late File file;

   List <dynamic>? fetchedImagesPath = [];

  @override
  void initState(){
    final box = GetStorage();
    fetchedImagesPath = box.read('ImagesPath');
    print(fetchedImagesPath);
  print(widget.savedFilePath);

  if (widget.savedFilePath.endsWith('4')){
    videoPlayerController = VideoPlayerController.file(file);
    videoPlayerController!.initialize();
    videoPlayerController!.play();
  }

    super.initState();
  }

  void dispose(){
    if(videoPlayerController != null){
      videoPlayerController!.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child:widget.savedFilePath == '' ? Center(child: Text('Didnt picked')) :

        ( (widget.savedFilePath[widget.savedFilePath.length-1]) == 'g' ?

        PageView.builder(
          scrollDirection: Axis.vertical,
            itemCount: fetchedImagesPath!.length,
            itemBuilder: (context,index){

              file = File(fetchedImagesPath![index]);
              return InkWell(
                onTap: (){
                  videoPlayerController!.pause();
                },
                  onDoubleTap: (){
                  videoPlayerController!.play();
                  },
                  child: Image.file(file));
            },
           ) :

        VideoPlayer(videoPlayerController!))

      ),
    );
  }

}


