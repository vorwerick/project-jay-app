part of 'file_cubit.dart';

@immutable
abstract class FileState {}

class FileInitial extends FileState {}

class FileExternallySuccess extends FileState {
  final String fileName;

  FileExternallySuccess(this.fileName);
}

class FileLocalSuccess extends FileState {
  final String filePath;

  FileLocalSuccess(this.filePath);
}

class FileLoadFailure extends FileState {
  final String fileName;

  FileLoadFailure(this.fileName);
}
