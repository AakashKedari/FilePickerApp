import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});
  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  List<VideoPlayerController> videoControllers = [];

  List <dynamic> fetchedImagesPath = [];
   List <dynamic> fetchedVideosPath = [];
   String savedFilePath = '' ;

  @override
  void initState()  {
    final box = GetStorage();
    // Firstly we check if the app is just installed and opened for first time
    if (box.read('VideosPath') == null || box.read('VideosPath') == 'Not Assigned') {
      box.write('VideosPath', 'Not Assigned');
    }
    else {
      fetchedVideosPath = box.read('VideosPath');
    }
    // Firstly we check if the app is just installed and opened for first time
    if (box.read('ImagesPath') == null || box.read('ImagesPath') == 'Not Assigned') {
      box.write('ImagesPath', 'Not Assigned');
    }
    else {
      fetchedImagesPath = box.read('ImagesPath');
    }
    initialiseVideoControllers();
    }

  void initialiseVideoControllers() {
    for (String videoPath in fetchedVideosPath) {
      File file = File(videoPath);
      VideoPlayerController controller = VideoPlayerController.file(file);
      controller.initialize();
      controller.play();
      controller.setLooping(true);
      videoControllers.add(controller);

    }
  }

  // fetchedVideosPath = box.read('VideosPath');
  // Function to save any type of file permanently in the app

  Future<File> saveFilePermanently (PlatformFile file) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final newfile = File('${appStorage.path}/${file.name}');
  return File('${file.path}').copy(newfile.path);
}

final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FilePicker'),
          centerTitle: true,
        ),
        body : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : [
            Column(
              children: [
               Text('Images',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.pink),),
                box.read('ImagesPath') == 'Not Assigned' ? Center(child: Text('Nothing Saved'),) :
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: PageView.builder(
                  itemCount: fetchedImagesPath.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  File file;
                  file = File(fetchedImagesPath[index]);
                  return Center(child: Image.file(file));
                }, )),
              ]
            ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children:[
                     Text('Videos',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.pink),),
                     box.read('VideosPath') == 'Not Assigned' ? Text('Nothing Saved') :
                     Container(
              decoration: BoxDecoration(

                shape: BoxShape.rectangle
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              child : PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: videoControllers.length,
                      itemBuilder: (context, index) {
                        videoControllers[index].play();
                        return InkWell(
                          onTap: (){
                            videoControllers[index].pause();
                          },
                            onDoubleTap: (){
                            videoControllers[index].play();
                            },
                            child: VideoPlayer(videoControllers[index]));
                      },
                onPageChanged: (index){
                        videoControllers[index].play();
                },
                    ),
            ),
                   ]
                 ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: ()async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.image
                      );
                      if (result == null) return;
                      final file = result.files.first;
                      final savedFile = await saveFilePermanently(file);
                      savedFilePath = savedFile.path;
                      final box = GetStorage();
                      fetchedImagesPath.add(savedFilePath);
                      box.write('ImagesPath', fetchedImagesPath);
                      setState(() {

                      });
                    },child :const Text('Add a Image')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 5),
                    onPressed: ()async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.video
                      );
                      if (result == null) return;
                      final file = result.files.first;
                      final savedFile = await saveFilePermanently(file);
                      savedFilePath = savedFile.path;
                      final box = GetStorage();
                      fetchedVideosPath.add(savedFilePath);
                      box.write('VideosPath', fetchedVideosPath);
                      setState(() {
                        videoControllers.clear();
                          initialiseVideoControllers();
                      });
                    }, child : const Text('Add a Video')),
              ],
            ),
            // ElevatedButton(onPressed: (){
            //   Navigator.push(context,MaterialPageRoute(builder: (context) =>SavedVideosPage() ));
            // }, child: Text('All Saved Videos')),
          ]
        )
      ),
    );
  }
}


