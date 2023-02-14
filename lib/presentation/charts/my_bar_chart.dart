import 'dart:developer';

import 'package:charts_sample_project/domain/chart_entry.dart';
import 'package:charts_sample_project/presentation/ui_helpers/bar_gradient.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyBarChart extends StatelessWidget {
  final List<ChartEntry> entries;

  const MyBarChart({
    Key? key,
    required this.entries,
  }) : super(key: key);

  List<BarChartGroupData> _getBarGroups(List<ChartEntry> entries) {

    List<BarChartGroupData> groupList = List<BarChartGroupData>.empty(growable: true);

    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      groupList.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: entry.value.toDouble(),
              gradient: barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return groupList;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: _getBarGroups(entries),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.blue,
            strokeWidth: 0.5,
            dashArray: [
              5,
              10
            ], //Defines dash effect of the line. 5 is line, 10 is space
          ),
        ),
        minY: 0,
        maxY: 20,
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            width: 1,
            color: Colors.yellow,
          ),
        ),
        alignment: BarChartAlignment.spaceBetween,
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
          )),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                final date = entries[index].date;
                final String formattedDate =
                    DateFormat('yMd').format(date);
                return Text(formattedDate);
              },
              showTitles: true,
              interval: 1,
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          handleBuiltInTouches: false,
          touchCallback: (touchEvent, touchResponse) {
            // Index
            final int? groupIndex = touchResponse?.spot?.touchedBarGroupIndex;
            final int? rodDataIndex = touchResponse?.spot?.touchedRodDataIndex;

            log("groupIndex: $groupIndex");
            log("rodDataIndex: $rodDataIndex");

            // Position
            final touchPositionX = touchEvent.localPosition?.dx;
            final touchPositionY = touchEvent.localPosition?.dy;
            log("touchOffset[ x: $touchPositionX, y: $touchPositionY ]");

            // Values
            if (groupIndex != null) {
              final date = entries[groupIndex].date;
              final value = entries[groupIndex].value;
              log("Values[ date: $date, value: $value ]");
            }
          },
        ),
      ),
    );
  }
}
