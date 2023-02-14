import 'package:equatable/equatable.dart';

abstract class ChartError extends Equatable {
  const ChartError(this.message);
  final String message;
}

class ChartDataEmpty extends ChartError {
  const ChartDataEmpty(super.message);

  @override
  List<Object?> get props => [message];
}

class ChartUnknownError extends ChartError {
  const ChartUnknownError(super.message);
  @override
  List<Object?> get props => [message];
}








