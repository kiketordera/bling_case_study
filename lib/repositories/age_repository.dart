import 'package:bling_case_study/blocs/age_estimator_bloc.dart';
import 'package:bling_case_study/models/age_estimate.dart';
import 'package:bling_case_study/services/agift.dart';

class AgeRepository {
  final ApiService apiService;

  AgeRepository(this.apiService);

  Future<AgeEstimate> getAgeEstimate(String name) async {
    try {
      return await apiService.getAgeEstimate(name);
    } catch (e) {
      if (e is NetworkException) {
        throw NetworkException();
      } else {
        throw ApiException();
      }
    }
  }
}
