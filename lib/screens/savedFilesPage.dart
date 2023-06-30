// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class SavedFilesPage extends StatefulWidget {
//   const SavedFilesPage({super.key});
//   @override
//   State<SavedFilesPage> createState() => _SavedFilesPageState();
// }
//
// class _SavedFilesPageState extends State<SavedFilesPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Saved Files'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 8,
//               crossAxisSpacing: 8,
//             ),
//             itemBuilder: (
//                 context,index
//                 ){
//               return customWidget();
//             },
//             itemCount : 8,
//         ),
//       ),
//     );
//   }
// }
// getColor(){
//
// }
// Widget customWidget(PlatformFile file)
// {
//   final color = getColor();
//     final extension = file.extension ?? 'none';
//     return InkWell(
//       onTap: (){},
//       child: Container(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: Container(
//               alignment: Alignment.center,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(
//                 '.$extension',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             )),
//             SizedBox(height: 8,),
//             Text(file.name,style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//             // For Handling Overflow of text
//               overflow: TextOverflow.ellipsis,
//             )
//           ],
//         ),
//       ),
//     );
// };
