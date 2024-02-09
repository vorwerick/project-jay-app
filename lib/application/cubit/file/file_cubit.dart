import 'dart:developer';
import 'dart:io';

import 'package:app/application/commands/open_file_async_cmd.dart';
import 'package:app/application/dto/file_pair_dto.dart';
import 'package:app/application/extensions/file_utils_extension.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileInitial());

  void openFile(final FilePairDto filePair) async {
    log('Opening file: ${filePair.name}', name: 'FileCubit');
    final File file = File(filePair.path);

    if (!file.isPdf) {
      if (await OpenFileAsyncCmd(file).execute()) {
        log('File opened externally', name: 'FileCubit');
        emit(FileExternallySuccess(filePair.name));
      } else {
        log('Failed to open file', name: 'FileCubit');
        emit(FileLoadFailure(filePair.name));
      }
    } else {
      log('File id pdf - opened locally', name: 'FileCubit');
      emit(FileLocalSuccess(filePair.name));
    }
  }
}
