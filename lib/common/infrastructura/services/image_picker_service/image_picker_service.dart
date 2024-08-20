import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    try {
      Directory? directory = await getApplicationDocumentsDirectory();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final String path = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
        final file = File(pickedFile.path);
        final File savedImage = await file.copy(path);
        return savedImage;
      }
    } catch (e) {
      print("Error picking image from gallery: $e");
    }
    return null;
  }

  Future<File?> captureImageWithCamera() async {
    try {
      Directory? directory = await getApplicationDocumentsDirectory();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final String path = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
        final file = File(pickedFile.path);
        final File savedImage = await file.copy(path);
        return savedImage;
      }
    } catch (e) {
      print("Error capturing image with camera: $e");
    }
    return null;
  }
}
