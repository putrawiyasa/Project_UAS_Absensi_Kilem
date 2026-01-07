import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras.firstWhere((e) => e.lensDirection == CameraLensDirection.front),
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF005CB0);

    if (!_controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              height: 56,
              width: double.infinity,
              color: primaryColor,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Ambil Gambar Untuk Absensi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.previewSize!.height,
                      height: _controller.value.previewSize!.width,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 65,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FloatingActionButton(
                      backgroundColor: primaryColor,
                      onPressed: () async {
                        final image = await _controller.takePicture();
                        Navigator.pop(context, image.path);
                      },
                      child: const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
