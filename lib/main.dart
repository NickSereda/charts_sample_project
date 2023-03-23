import 'package:charts_sample_project/application/chart_cubit.dart';
import 'package:charts_sample_project/infrastructure/chart_repository.dart';
import 'package:charts_sample_project/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<ChartRepository>(DevChartRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartCubit>(
      create: (context) => ChartCubit(getIt.get<ChartRepository>())..getData(),
      child: const MaterialApp(
        home: MainScreen(),
      ),
    );
  }
}
