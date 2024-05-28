import 'package:bling_case_study/presentation/blocs/age/age_estimator_bloc.dart';
import 'package:bling_case_study/data/models/age_estimate.dart';
import 'package:bling_case_study/data/services/agify.dart';
import 'package:bling_case_study/domain/repository/age_estimate_repo.dart';

class AgeRepoImpl implements AgeRepository {
  final ApiService apiService;

  AgeRepoImpl(this.apiService);

  @override
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
