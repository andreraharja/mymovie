import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warning'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Please Check Your Connection',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
