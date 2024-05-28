part of 'age_estimator_bloc.dart';

sealed class AgeEstimatorEvent extends Equatable {
  const AgeEstimatorEvent();

  @override
  List<Object> get props => [];
}

final class GetAgeEstimate extends AgeEstimatorEvent {
  final String name;

  const GetAgeEstimate(this.name);
}

class ResetAgeEstimator extends AgeEstimatorEvent {}