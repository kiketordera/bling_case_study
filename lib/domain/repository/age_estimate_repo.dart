import 'package:bling_case_study/data/models/age_estimate.dart';
abstract class AgeRepository {
  Future<AgeEstimate> getAgeEstimate(String name);
}
