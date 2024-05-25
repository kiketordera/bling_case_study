import 'package:bling_case_study/blocs/age_estimator_bloc.dart';
import 'package:bling_case_study/models/age_estimate.dart';
import 'package:bling_case_study/repositories/age_repository.dart';
import 'package:bling_case_study/services/agift.dart';
import 'package:bling_case_study/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeEstimatorScreen extends StatelessWidget {
  const AgeEstimatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Estimator')),
      body: BlocProvider(
        create: (context) => AgeEstimatorBloc(AgeRepository(ApiService())),
        child: const AgeEstimatorForm(),
      ),
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

  void _showResult(BuildContext context, AgeEstimate ageEstimate) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetContent(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${ageEstimate.name}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Estimated Age: ${ageEstimate.age}',
                        style: const TextStyle(fontSize: 20)),
                    Text('Count: ${ageEstimate.count}',
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
            onPressed: () {
              final name = _controller.text;
              if (name.isNotEmpty) {
                BlocProvider.of<AgeEstimatorBloc>(context)
                    .add(GetAgeEstimate(name));
              }
            },
            child: const Text('Get Age Estimate'),
          ),
          const SizedBox(height: 20),
          BlocConsumer<AgeEstimatorBloc, AgeEstimatorState>(
            listener: (context, state) {
              if (state is AgeEstimatorLoaded) {
                _showResult(context, state.ageEstimate);
              } else if (state is AgeEstimatorError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is AgeEstimatorInitial) {
                return const Text('Enter a name to get an age estimate.');
              } else if (state is AgeEstimatorLoading) {
                return const CircularProgressIndicator();
              }
              return Container();
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _controller.clear();
              BlocProvider.of<AgeEstimatorBloc>(context)
                  .add(ResetAgeEstimator());
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
