import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AllImagesPage extends StatefulWidget {
  const AllImagesPage({super.key});
  @override
  State<AllImagesPage> createState() => _AllImagesPageState();
}

class _AllImagesPageState extends State<AllImagesPage> {

  List <dynamic>? fetchedImagesPath = [];

  @override
  void initState() {
    final box = GetStorage();
    if (box.read('ImagesPath') != 'Not Assigned'){
      fetchedImagesPath =box.read('ImagesPath');
    }
    print(fetchedImagesPath);
    super.initState();
  }

  final box = GetStorage();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('All Picked Images'),
        centerTitle: true,
      ),
      body: box.read('ImagesPath') == 'Not Assigned' ? Center(child: Text('Nothing Saved'),) :

      PageView.builder(
          itemCount: fetchedImagesPath!.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context,index){
            File file;
          file = File(fetchedImagesPath![index]);
          return Center(child: Image.file(file));
        },
          ),
    );
  }
}
