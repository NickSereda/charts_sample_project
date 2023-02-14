import 'package:charts_sample_project/domain/chart_entry.dart';
import 'package:charts_sample_project/infrastructure/converters/line_chart_date_convertor.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyLineChart extends StatelessWidget {
  final List<ChartEntry> entries;

  const MyLineChart({
    Key? key,
    required this.entries,
  }) : super(key: key);

  List<LineChartBarData> _getLineBarsData(List<ChartEntry> entries) {
    return [
      LineChartBarData(
        isCurved: true,
        color: Colors.orange.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.yellowAccent.withOpacity(0.2),
        ),
        spots: LineChartDateConverter.convert(entries),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      // Optional if we change sampleData:
      // isShowingMainData ? sampleData1 : sampleData2,
      // swapAnimationDuration: const Duration(milliseconds: 150),
      // swapAnimationCurve: Curves.linear, // Optional
    );
  }

  LineChartData get sampleData => LineChartData(
        gridData: FlGridData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                return Text(value.toString());
              },
              showTitles: true,
              // maxY/ number of
              interval: 1,
              reservedSize: 60,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                // value is timestamp
                final DateTime date =
                    DateTime.fromMillisecondsSinceEpoch(value.toInt());
                final String formattedDate = DateFormat('d').format(date);
                return Text(formattedDate);
              },
              showTitles: true,
              // one day in milliseconds (as timestamp)
              interval: 86400000,
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(
          show: true,
          border:
              Border.all(color: Colors.yellowAccent.withOpacity(0.2), width: 4),
        ),
        lineBarsData: _getLineBarsData(entries),
        minY: 0,
        maxY: 20,
        minX: DateTime(2023, 2, 1).millisecondsSinceEpoch.toDouble(),
        maxX: DateTime(2023, 2, 14).millisecondsSinceEpoch.toDouble(),
      );

// DUMMY DATA
//
// List<LineChartBarData> get lineBarsData2 => [
//   lineChartBarData2_1,
//   lineChartBarData2_2,
//   lineChartBarData2_3,
// ];
//
// LineChartBarData get lineChartBarData2_1 => LineChartBarData(
//       isCurved: true,
//       curveSmoothness: 0,
//       color: Colors.brown.withOpacity(0.5),
//       barWidth: 6,
//       isStrokeCapRound: true,
//       dotData: FlDotData(show: false),
//       belowBarData: BarAreaData(show: false),
//       spots: const [
//         FlSpot(1, 1),
//         FlSpot(3, 4),
//         FlSpot(5, 1.8),
//         FlSpot(7, 5),
//         FlSpot(10, 2),
//         FlSpot(12, 2.2),
//         FlSpot(13, 1.8),
//       ],
//     );
//
// LineChartBarData get lineChartBarData2_2 => LineChartBarData(
//       isCurved: true,
//       color: Colors.orange.withOpacity(0.5),
//       barWidth: 4,
//       isStrokeCapRound: true,
//       dotData: FlDotData(show: false),
//       belowBarData: BarAreaData(
//         show: true,
//         color: Colors.yellowAccent.withOpacity(0.2),
//       ),
//       spots: const [
//         FlSpot(1, 1),
//         FlSpot(3, 2.8),
//         FlSpot(7, 1.2),
//         FlSpot(10, 2.8),
//         FlSpot(12, 2.6),
//         FlSpot(13, 3.9),
//       ],
//     );
//
// LineChartBarData get lineChartBarData2_3 => LineChartBarData(
//       isCurved: true,
//       curveSmoothness: 0,
//       color: Colors.blueGrey.withOpacity(0.5),
//       barWidth: 2,
//       isStrokeCapRound: true,
//       dotData: FlDotData(show: true),
//       belowBarData: BarAreaData(show: false),
//       spots: const [
//         FlSpot(1, 3.8),
//         FlSpot(3, 1.9),
//         FlSpot(6, 5),
//         FlSpot(10, 3.3),
//         FlSpot(13, 4.5),
//       ],
//     );
}
