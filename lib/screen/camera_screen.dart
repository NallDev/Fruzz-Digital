import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class MyCameraScreen extends StatelessWidget {
  const MyCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CameraAwesomeBuilder.awesome(
          saveConfig: SaveConfig.photo(exifPreferences: ExifPreferences(saveGPSLocation: false),),
          onMediaTap: (mediaCapture) {
            OpenFile.open(mediaCapture.captureRequest.path);
          },
          enablePhysicalButton: true,
          previewFit: CameraPreviewFit.contain,
          theme: AwesomeTheme(
            // Background color of the bottom actions
            bottomActionsBackgroundColor: Colors.deepPurple.withOpacity(0.5),
            // Buttons theme
            buttonTheme: AwesomeButtonTheme(
              // Background color of the button
              backgroundColor: Colors.deepPurple.withOpacity(0.5),
              // Size of the icon
              iconSize: 32,
              // Padding around the icon
              padding: const EdgeInsets.all(18),
              // Color of the icon
              foregroundColor: Colors.lightBlue,
              // Tap visual feedback (ripple, bounce...)
              buttonBuilder: (child, onTap) {
                return ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: InkWell(
                      splashColor: Colors.deepPurple,
                      highlightColor: Colors.deepPurpleAccent.withOpacity(0.5),
                      onTap: () => print("HELLO"),
                      child: child,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}