import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File? photo;
  final ImagePicker picker = ImagePicker();

  //for camera
  Future imgForCamera() async
  {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
            maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 100,
    );

    setState(() {
      if(pickedFile !=null)
        {
          photo = File(pickedFile.path);
        }
      else
        {
          print("No image selected");
        }
    });
  }

  //for gallery
  Future imgForGallery() async
  {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 100,
    );

    setState(() {
      if(pickedFile !=null)
      {
        photo = File(pickedFile.path);
      }
      else
      {
        print("No image selected");
      }
    });
  }



  //for bottom sheet dialog
  void showBottomSheetDialog(context){

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
      return SafeArea(child: Wrap(
        children: [
          ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text("Camera"),
          onTap: ()
          {
            //call function for open camera
            imgForCamera();
            Navigator.of(context).pop();
          },
        ),

          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Gallery"),
            onTap: ()
            {
              //call function for open gallery
              imgForGallery();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Image Picker", style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Column(
        children: [
          
          photo != null ? Image.file(photo!,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height/2,
          fit: BoxFit.fitWidth,

          ) :

          Image.asset("assets/images/image_placeholder.jpg",
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height/2,
          fit: BoxFit.fitWidth,
          ),

          const SizedBox(height: 20,),

          SizedBox(
            width: 200,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
                onPressed: (){
                  //call function
                  showBottomSheetDialog(context);

            }, child: const Text("Pick Images", style: TextStyle(
              color: Colors.white,
            ),)),
          )

        ],
      ),
    );
  }
}
