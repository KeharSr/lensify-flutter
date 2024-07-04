import 'package:flutter/material.dart';

class FeebackView extends StatefulWidget {
  const FeebackView({super.key});

  @override
  State<FeebackView> createState() => _FeebackViewState();
}

class _FeebackViewState extends State<FeebackView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Center(
        child: Text('Feedback'),
      ),
    );
  }
}
