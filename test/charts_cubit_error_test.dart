import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:charts_sample_project/domain/chart_error.dart';
import 'package:charts_sample_project/application/chart_cubit.dart';

import 'package:mockito/mockito.dart';
import 'charts_cubit_test.mocks.dart';

final getIt = GetIt.instance;

void main() {
  ChartCubit _setUpDependencies() {
    getIt.registerSingleton<MockDevChartRepository>(
      MockDevChartRepository(),
    );
    when(
      getIt<MockDevChartRepository>().getChartData(),
    ).thenAnswer(
      (_) async => const Right(
        ChartDataEmpty("chart data empty"),
      ),
    );
    return ChartCubit(
      getIt<MockDevChartRepository>(),
    );
  }

  tearDown(() async {
    await getIt.reset();
  });

  group('Charts error cubit test', () {
    blocTest<ChartCubit, ChartState>(
      'ChartCubit emits loading state and loaded state when getData() is called',
      build: _setUpDependencies,
      act: (bloc) async {
        await bloc.getData();
      },
      expect: () => [
        ChartsLoadingState(),
        ChartsErrorState(
          error: const ChartDataEmpty("chart data empty"),
        ),
      ],
    );
  });
}
