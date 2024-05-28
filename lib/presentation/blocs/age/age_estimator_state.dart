part of 'age_estimator_bloc.dart';

sealed class AgeEstimatorState extends Equatable {
  const AgeEstimatorState();

  @override
  List<Object> get props => [];
}

final class AgeEstimatorInitial extends AgeEstimatorState {}

class AgeEstimatorLoading extends AgeEstimatorState {}

class AgeEstimatorLoaded extends AgeEstimatorState {
  final AgeEstimate ageEstimate;

  const AgeEstimatorLoaded(this.ageEstimate);
}

class AgeEstimatorError extends AgeEstimatorState {
  final String message;

  const AgeEstimatorError(this.message);
}
