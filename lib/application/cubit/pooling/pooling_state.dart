part of 'pooling_cubit.dart';

@immutable
sealed class PoolingState {}

final class PoolingStarted extends PoolingState {}

final class PoolingFetched extends PoolingState {}

