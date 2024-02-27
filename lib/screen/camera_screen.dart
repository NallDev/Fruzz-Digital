import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_story_app/provider/camera_provider.dart';
import 'package:my_story_app/screen/post_story_screen.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:provider/provider.dart';

class MyCameraScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  MyCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CameraProvider(),
      child: Scaffold(
        body: Consumer<CameraProvider>(
          builder: (context, cameraProvider, child) {
            if (!cameraProvider.isReady) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: <Widget>[
                Stack(
                  children: [
                    cameraProvider.controller == null || !cameraProvider.controller!.value.isInitialized
                        ? const Center(child: Text('Loading Camera...'))
                        : CameraPreview(cameraProvider.controller!),

                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0, top: 16.0),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: const Color(borderColor), width: 1),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Color(borderColor),),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: const Color(borderColor), width: 1),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: IconButton(
                          icon: const Icon(Icons.image_outlined, color: Color(primaryColor),),
                          onPressed: () async {
                            var file = await _picker.pickImage(source: ImageSource.gallery);

                            if (file == null) return;
                            if (!context.mounted) return;

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyPostStoryScreen(imagePath: File(file.path)),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: const Color(borderColor), width: 1),
                            borderRadius: BorderRadius.circular(100.0)),
                        child: IconButton(
                          icon: const Icon(Icons.circle, color: Color(primaryColor),),
                          onPressed: () async {
                            var file = await Provider.of<CameraProvider>(context, listen: false).takePicture();
                            if (file != null) {
                              if(!context.mounted) return;
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyPostStoryScreen(imagePath: File(file.path)),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      if (cameraProvider.cameras != null && cameraProvider.cameras!.length > 1)
                        Container(
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: const Color(borderColor), width: 1),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: IconButton(
                            icon: const Icon(Icons.switch_camera_outlined, color: Color(primaryColor),),
                            onPressed: () {
                              Provider.of<CameraProvider>(context, listen: false).switchCamera();
                            },
                          ),
                        ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
