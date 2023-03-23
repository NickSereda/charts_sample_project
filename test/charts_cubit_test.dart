import 'package:bloc_test/bloc_test.dart';
import 'package:charts_sample_project/domain/chart_entry.dart';
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
  ChartCubit _setUpDependencies() {
    getIt.registerSingleton<MockDevChartRepository>(
      MockDevChartRepository(),
    );
    when(
      getIt<MockDevChartRepository>().getChartData(),
    ).thenAnswer(
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
    return ChartCubit(
      getIt<MockDevChartRepository>(),
    );
  }

  tearDown(() async {
    await getIt.reset();
  });

  group('Charts cubit test', () {
    // Can not test initial state, since we call getChartData() in constructor.
    test('initial state is ChartsInitialState', () {
      final cubit = _setUpDependencies();
      expect(cubit.state, ChartsInitialState());
    });

    blocTest<ChartCubit, ChartState>(
      'ChartCubit emits loading state and loaded state when getData() is called',
      build: _setUpDependencies,
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
}
