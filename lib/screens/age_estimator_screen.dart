import 'package:bling_case_study/services/agift.dart';
import 'package:bling_case_study/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class AgeEstimatorScreen extends StatelessWidget {
  const AgeEstimatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Estimator')),
      body: const AgeEstimatorForm(),
    );
  }
}

class AgeEstimatorForm extends StatefulWidget {
  const AgeEstimatorForm({super.key});

  @override
  AgeEstimatorFormState createState() => AgeEstimatorFormState();
}

class AgeEstimatorFormState extends State<AgeEstimatorForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter Name'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final name = _controller.text;
              if (name.isNotEmpty) {
                var api = ApiService();
                var d = await api.getAgeEstimate(name);

                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (context) {
                    return BottomSheetContent(ageEstimate: d);
                  },
                );

                print("age is:");
                print(d.age);
              }
            },
            child: const Text('Get Age Estimate'),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _controller.clear();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
