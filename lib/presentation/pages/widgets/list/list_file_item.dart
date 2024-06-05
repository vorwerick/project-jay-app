import 'package:app/application/dto/file_pair_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/widgets/badges/badge_icon.dart';
import 'package:flutter/material.dart';

final class ListFileItem extends StatelessWidget {
  final FilePairDto filePair;
  final void Function(String)? onFileSelected;

  const ListFileItem({
    required this.filePair,
    this.onFileSelected,
  });

  @override
  Widget build(final BuildContext context) => Material(
        color: Colors.white,
        child: InkWell(
          splashColor: JayColors.lightGrey,
          onTap: () => onFileSelected?.call(filePair.path),
          child: SizedBox(),
        ),
      );
}
