import 'package:charts_sample_project/application/chart_cubit.dart';
import 'package:charts_sample_project/presentation/charts/my_bar_chart.dart';
import 'package:charts_sample_project/presentation/charts/my_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ChartCubit, ChartState>(
          listener: (context, state) {
            if (state is ChartsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ChartsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ChartsLoadedState) {
              return Padding(
                padding: const EdgeInsets.all(26.0),
                child: MyLineChart(entries: state.entries),
                // child: MyBarChart(entries: state.entries),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
