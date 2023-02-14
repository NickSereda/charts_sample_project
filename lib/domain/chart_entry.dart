
import 'package:equatable/equatable.dart';

class ChartEntry extends Equatable {

  const ChartEntry({
    required this.date,
    required this.value,
  });

  final DateTime date;
  final int value;

  @override
  List<Object?> get props => [date, value];
}
