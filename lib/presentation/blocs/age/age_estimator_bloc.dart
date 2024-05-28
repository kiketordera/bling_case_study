import 'package:bling_case_study/domain/repository/age_estimate_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bling_case_study/data/models/age_estimate.dart';

part 'age_estimator_event.dart';
part 'age_estimator_state.dart';

class AgeEstimatorBloc extends Bloc<AgeEstimatorEvent, AgeEstimatorState> {
  final AgeRepository ageRepository;

  AgeEstimatorBloc(this.ageRepository) : super(AgeEstimatorInitial()) {
    on<GetAgeEstimate>(_onGetAgeEstimate);
    on<ResetAgeEstimator>((event, emit) => emit(AgeEstimatorInitial()));
  }

  void _onGetAgeEstimate(
      GetAgeEstimate event, Emitter<AgeEstimatorState> emit) async {
    emit(AgeEstimatorLoading());
    try {
      final ageEstimate = await ageRepository.getAgeEstimate(event.name);
      emit(AgeEstimatorLoaded(ageEstimate));
    } catch (e) {
      String errorMessage;
      if (e is NetworkException) {
        errorMessage = 'Failed to connect to the network. Please try again.';
      } else if (e is ApiException) {
        errorMessage =
            'Failed to fetch age estimate from the server. Please try again later.';
      } else {
        errorMessage = 'An unexpected error occurred. Please try again.';
      }
      emit(AgeEstimatorError(errorMessage));
    }
  }
}

class NetworkException implements Exception {}

class ApiException implements Exception {}
