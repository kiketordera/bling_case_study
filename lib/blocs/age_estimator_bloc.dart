import 'package:bling_case_study/models/age_estimate.dart';
import 'package:bling_case_study/repositories/age_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AgeEstimatorEvent {}

class GetAgeEstimate extends AgeEstimatorEvent {
  final String name;

  GetAgeEstimate(this.name);
}

class ResetAgeEstimator extends AgeEstimatorEvent {}

// States
abstract class AgeEstimatorState {}

class AgeEstimatorInitial extends AgeEstimatorState {}

class AgeEstimatorLoading extends AgeEstimatorState {}

class AgeEstimatorLoaded extends AgeEstimatorState {
  final AgeEstimate ageEstimate;

  AgeEstimatorLoaded(this.ageEstimate);
}

class AgeEstimatorError extends AgeEstimatorState {
  final String message;

  AgeEstimatorError(this.message);
}

// BLoC
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
