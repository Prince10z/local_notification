import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key, required this.payload});
  final String payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Another"),
      ),
      body: Column(
        children: [Text("This is you payload"), Text(payload)],
      ),
    );
  }
}
