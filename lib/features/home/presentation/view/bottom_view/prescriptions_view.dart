import 'package:flutter/material.dart';

class PrescriptionsView extends StatefulWidget {
  const PrescriptionsView({super.key});

  @override
  State<PrescriptionsView> createState() => _PrescriptionsViewState();
}

class _PrescriptionsViewState extends State<PrescriptionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Prescriptions'),
      ),
      body: const Center(
        child: Text('Prescriptions View'),
      ),
    );
  }
}
