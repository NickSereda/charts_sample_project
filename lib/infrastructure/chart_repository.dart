import 'package:charts_sample_project/domain/chart_entry.dart';
import 'package:charts_sample_project/domain/chart_error.dart';
import 'package:dartz/dartz.dart';

abstract class ChartRepository {
  Future<Either<List<ChartEntry>, ChartError>> getChartData();
}

class DevChartRepository extends ChartRepository {
  @override
  Future<Either<List<ChartEntry>, ChartError>> getChartData() async {
    return Left(
      [
        ChartEntry(date: DateTime(2023, 2, 2), value: 18),
        ChartEntry(date: DateTime(2023, 2, 4), value: 7),
        ChartEntry(date: DateTime(2023, 2, 7), value: 10),
        ChartEntry(date: DateTime(2023, 2, 10), value: 17),
        ChartEntry(date: DateTime(2023, 2, 13), value: 10),
      ],
    );
  }
}
