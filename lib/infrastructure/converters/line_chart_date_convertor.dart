import 'package:charts_sample_project/domain/chart_entry.dart';
import 'package:fl_chart/fl_chart.dart';

// DateTime is converted to timestamp
abstract class LineChartDateConverter {
  static List<FlSpot> convert(List<ChartEntry> data) {
    return List<FlSpot>.generate(
      data.length,
      (index) {
        final int timestamp = data[index].date.millisecondsSinceEpoch;
        return FlSpot(timestamp.toDouble(), data[index].value.toDouble());
      },
    );
  }
}
