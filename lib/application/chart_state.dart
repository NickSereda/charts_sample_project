part of 'chart_cubit.dart';

abstract class ChartState extends Equatable {}

class ChartsInitialState extends ChartState {
  @override
  List<Object?> get props => [];
}

class ChartsLoadingState extends ChartState {
  @override
  List<Object?> get props => [];
}

class ChartsLoadedState extends ChartState {
  ChartsLoadedState({required this.entries});

  final List<ChartEntry> entries;
  @override
  List<Object?> get props => [entries];
}

class ChartsErrorState extends ChartState {
  ChartsErrorState({required this.error});
  final ChartError error;
  @override
  List<Object?> get props => [error];
}
