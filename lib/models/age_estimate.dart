class AgeEstimate {
  final String name;
  final int age;
  final int count;

  AgeEstimate({required this.name, required this.age, required this.count});

  factory AgeEstimate.fromJson(Map<String, dynamic> json) {
    return AgeEstimate(
      name: json['name'],
      age: json['age'],
      count: json['count'],
    );
  }
}
