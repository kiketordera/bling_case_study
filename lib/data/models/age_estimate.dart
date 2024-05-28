import 'package:equatable/equatable.dart';

class AgeEstimate extends Equatable {
  final String name;
  final int age;
  final int count;

  const AgeEstimate({required this.name, required this.age, required this.count});

  factory AgeEstimate.fromJson(Map<String, dynamic> json) {
    return AgeEstimate(
      name: json['name'],
      age: json['age'],
      count: json['count'],
    );
  }
  
  @override
 
  List<Object?> get props => [name, age, count];
}
