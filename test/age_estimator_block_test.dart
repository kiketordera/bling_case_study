import 'package:bling_case_study/blocs/age_estimator_bloc.dart';
import 'package:bling_case_study/models/age_estimate.dart';
import 'package:bling_case_study/repositories/age_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAgeRepository extends Mock implements AgeRepository {}

void main() {
  late MockAgeRepository mockAgeRepository;
  late AgeEstimatorBloc ageEstimatorBloc;

  setUp(() {
    mockAgeRepository = MockAgeRepository();
    ageEstimatorBloc = AgeEstimatorBloc(mockAgeRepository);
  });

  tearDown(() {
    ageEstimatorBloc.close();
  });

  test('initial state is AgeEstimatorInitial', () {
    expect(ageEstimatorBloc.state, AgeEstimatorInitial());
  });

  group('AgeEstimatorBloc', () {
    blocTest<AgeEstimatorBloc, AgeEstimatorState>(
      'emits [AgeEstimatorLoading, AgeEstimatorLoaded] when age is fetched successfully',
      build: () {
        // Setup the mock repository
        when(mockAgeRepository.getAgeEstimate('John')).thenAnswer(
            (_) async => AgeEstimate(name: 'John', age: 25, count: 100));
        return AgeEstimatorBloc(mockAgeRepository);
      },
      act: (bloc) => bloc.add(GetAgeEstimate('John')),
      expect: () => [
        AgeEstimatorLoading(),
        AgeEstimatorLoaded(AgeEstimate(name: 'John', age: 25, count: 100)),
      ],
    );

    blocTest<AgeEstimatorBloc, AgeEstimatorState>(
      'emits [AgeEstimatorLoading, AgeEstimatorError] when fetching age fails',
      build: () {
        // Setup the mock repository
        when(mockAgeRepository.getAgeEstimate('Unknown'))
            .thenThrow(Exception('Failed to fetch age estimate'));
        return AgeEstimatorBloc(mockAgeRepository);
      },
      act: (bloc) => bloc.add(GetAgeEstimate('Unknown')),
      expect: () => [
        AgeEstimatorLoading(),
        AgeEstimatorError('Failed to fetch age estimate'),
      ],
    );
  });
}
