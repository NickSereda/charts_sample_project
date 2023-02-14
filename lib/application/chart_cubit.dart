import 'package:bloc/bloc.dart';
import 'package:charts_sample_project/domain/chart_entry.dart';
import 'package:charts_sample_project/domain/chart_error.dart';
import 'package:charts_sample_project/infrastructure/chart_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  final ChartRepository _chartRepository;

  ChartCubit(this._chartRepository) : super(ChartsInitialState()) {
    getData();
  }

  Future<void> getData() async {
    emit(ChartsLoadingState());
    final Either<List<ChartEntry>, ChartError> result =
        await _chartRepository.getChartData();
    return result.fold((entries) {
      emit(ChartsLoadedState(entries: entries));
    }, (error) {
      emit(ChartsErrorState(error: error));
    });
  }
}
