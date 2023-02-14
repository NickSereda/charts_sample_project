import 'package:bloc_test/bloc_test.dart';
import 'package:charts_sample_project/domain/chart_entry.dart';
import 'package:charts_sample_project/domain/chart_error.dart';
import 'package:charts_sample_project/infrastructure/chart_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:charts_sample_project/application/chart_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<DevChartRepository>()])
import 'charts_cubit_test.mocks.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<MockDevChartRepository>(MockDevChartRepository());

  group('Charts cubit test', () {
    late final ChartCubit cubit;
    late final MockDevChartRepository mockChartsRepo;

    setUp(() {
      mockChartsRepo = getIt<MockDevChartRepository>();

      when(mockChartsRepo.getChartData()).thenAnswer(
        (_) async => Left(
          [
            ChartEntry(date: DateTime(2023, 2, 2), value: 18),
            ChartEntry(date: DateTime(2023, 2, 4), value: 7),
            ChartEntry(date: DateTime(2023, 2, 7), value: 10),
            ChartEntry(date: DateTime(2023, 2, 10), value: 17),
            ChartEntry(date: DateTime(2023, 2, 13), value: 10),
          ],
        ),
      );
      cubit = ChartCubit(mockChartsRepo);
    });

    // Can not test initial state, since we call getChartData() in constructor.
    // test('initial state is ChartsInitialState', () {
    //   expect(cubit.state, ChartsInitialState());
    // });

    blocTest<ChartCubit, ChartState>(
      'ChartCubit emits loading state and loaded state when getData() is called',
      build: () => cubit,
      act: (bloc) => bloc.getData(),
      expect: () => [
        ChartsLoadingState(),
        ChartsLoadedState(
          entries: [
            ChartEntry(date: DateTime(2023, 2, 2), value: 18),
            ChartEntry(date: DateTime(2023, 2, 4), value: 7),
            ChartEntry(date: DateTime(2023, 2, 7), value: 10),
            ChartEntry(date: DateTime(2023, 2, 10), value: 17),
            ChartEntry(date: DateTime(2023, 2, 13), value: 10),
          ],
        ),
      ],
    );

  });


  group('Charts error cubit test', () {
      late final ChartCubit cubit;
      late final MockDevChartRepository mockChartsRepo;

      setUp(() {
        mockChartsRepo = getIt<MockDevChartRepository>();

        when(mockChartsRepo.getChartData()).thenAnswer(
          (_) async => const Right(ChartDataEmpty("chart data empty"))
        );
        cubit = ChartCubit(mockChartsRepo);
      });
      
      blocTest<ChartCubit, ChartState>(
        'ChartCubit emits loading state and loaded state when getData() is called',
        build: () {

          when(mockChartsRepo.getChartData()).thenAnswer((_) async => const Right(ChartDataEmpty("chart data empty"))
          );
          return cubit;
        },
        act: (bloc) async => bloc.getData(),
        expect: () => [
          ChartsLoadingState(),
          ChartsErrorState(
            error: const ChartDataEmpty("chart data empty"),
          ),
        ],
      );
  });


}
