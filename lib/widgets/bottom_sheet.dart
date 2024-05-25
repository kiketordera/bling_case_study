import 'package:bling_case_study/models/age_estimate.dart';
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key, required this.ageEstimate});
  final AgeEstimate ageEstimate;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Name: ${ageEstimate.name}',
                    style: const TextStyle(fontSize: 20)),
                Text('Estimated Age: ${ageEstimate.age}',
                    style: const TextStyle(fontSize: 20)),
                Text('Count: ${ageEstimate.count}',
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
            const Spacer(),
          ],
        ));
  }
}
