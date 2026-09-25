import 'dart:typed_data';


class AppModel {
  final String name;
  final String packageName;
  final Uint8List? iconBytes;

  AppModel({
    required this.name,
    required this.packageName,
    this.iconBytes,
  });
  

}