import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class AppEntity extends Equatable {
  final String name;
  final String packageName;
  final Uint8List? iconBytes;

  const AppEntity({
    required this.name,
    required this.packageName,
    this.iconBytes,
  });

  @override
  List<Object?> get props => [name, packageName];
}