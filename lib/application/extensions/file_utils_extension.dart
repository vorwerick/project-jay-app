import 'dart:io';

extension FileUtilsExtension on File {
  bool get isPdf => path.toLowerCase().endsWith('.pdf');
}
