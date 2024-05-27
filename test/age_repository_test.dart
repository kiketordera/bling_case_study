import 'package:bling_case_study/models/age_estimate.dart';
import 'package:bling_case_study/repositories/age_repository.dart';
import 'package:bling_case_study/services/agift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAgifyService extends Mock implements ApiService {}

void main() {
  late AgeRepository ageRepository;
  late MockAgifyService mockAgifyService;

  setUp(() {
    mockAgifyService = MockAgifyService();
    ageRepository = AgeRepository(mockAgifyService);
  });

  test('returns AgeEstimate when the call to Agify API is successful',
      () async {
    final ageEstimate = AgeEstimate(name: 'John', age: 25, count: 100);

    // Configure the mock response
    when(mockAgifyService.getAgeEstimate('John')).thenAnswer((_) async => ageEstimate);

    // Call the method and assert the result
    final result = await ageRepository.getAgeEstimate('John');

    expect(result, ageEstimate);
  });

  test('throws an exception when the call to Agify API fails', () async {
    // Configure the mock response to throw an exception
    when(mockAgifyService.getAgeEstimate('Unknown'))
        .thenThrow(Exception('Failed to fetch age estimate'));

    // Assert that the method throws the expected exception
    expect(() async => await ageRepository.getAgeEstimate('Unknown'),
        throwsException);
  });
}
