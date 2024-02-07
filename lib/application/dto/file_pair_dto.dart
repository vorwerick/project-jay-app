import 'package:equatable/equatable.dart';

final class FilePairDto extends Equatable {
  final String name;
  final String path;

  const FilePairDto({
    required this.name,
    required this.path,
  });

  @override
  List<Object?> get props => [name, path];

  @override
  bool? get stringify => super.stringify;
}
