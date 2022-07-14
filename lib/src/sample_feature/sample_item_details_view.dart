import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({Key? key}) : super(key: key);

  static const routeName = '/landlord/details';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
