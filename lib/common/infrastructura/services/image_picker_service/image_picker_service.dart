import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      Directory? appTmp = await getTemporaryDirectory();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final file = File(pickedFile.path);
        await file.writeAsBytes(bytes);
        return file;
      }
    } catch (e) {
      print("Error picking image from gallery: $e");
    }
    return null;
  }

  Future<File?> captureImageWithCamera() async {
    try {
      Directory? appTmp = await getTemporaryDirectory();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final file = File(pickedFile.path);
        await file.writeAsBytes(bytes);
        return file;
      }
    } catch (e) {
      print("Error capturing image with camera: $e");
    }
    return null;
  }
}
