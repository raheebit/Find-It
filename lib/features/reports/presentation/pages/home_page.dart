import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FindIt'),
      ),
      body: const Center(
        child: Text('Home screen — UI implementation comes next.'),
      ),
    );
  }
}
