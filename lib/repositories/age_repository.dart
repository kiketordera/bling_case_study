import 'package:bling_case_study/models/age_estimate.dart';
import 'package:bling_case_study/services/agift.dart';

class AgeRepository {
  final ApiService apiService;

  AgeRepository(this.apiService);

  Future<AgeEstimate> getAgeEstimate(String name) {
    return apiService.getAgeEstimate(name);
  }
}
