import 'package:bling_case_study/presentation/blocs/age/age_estimator_bloc.dart';
import 'package:bling_case_study/data/models/age_estimate.dart';
import 'package:bling_case_study/domain/repository/age_estimate_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateNiceMocks([MockSpec<AgeRepository>()])
import 'age_estimator_block_test.mocks.dart';

// class MockAgeRepository extends Mock implements AgeRepository {}

void main() {
  late MockAgeRepository mockAgeRepository;
  late AgeEstimatorBloc ageEstimatorBloc;

  setUp(() {
    // var mockAgeRepository = MockAge();
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
        // Setup the mock repository to return a Future<AgeEstimate> when called with any string argument
        when(mockAgeRepository.getAgeEstimate(any)).thenAnswer(
            (_) async => const AgeEstimate(name: 'John', age: 25, count: 100));
        return AgeEstimatorBloc(mockAgeRepository);
      },
      act: (bloc) => bloc.add(const GetAgeEstimate('John')),
      expect: () => [
        AgeEstimatorLoading(),
        const AgeEstimatorLoaded(
            AgeEstimate(name: 'John', age: 25, count: 100)),
      ],
    );

    blocTest<AgeEstimatorBloc, AgeEstimatorState>(
      'emits [AgeEstimatorLoading, AgeEstimatorError] when fetching age fails',
      build: () {
        // Setup the mock repository to throw an exception when called with any string argument
        when(mockAgeRepository.getAgeEstimate(any))
            .thenThrow(Exception('Failed to fetch age estimate'));
        return AgeEstimatorBloc(mockAgeRepository);
      },
      act: (bloc) => bloc.add(const GetAgeEstimate('Unknown')),
      expect: () => [
        AgeEstimatorLoading(),
        const AgeEstimatorError(
            'An unexpected error occurred. Please try again.'),
      ],
    );
  });
}
