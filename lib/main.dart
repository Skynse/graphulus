import 'package:flutter/material.dart';
import 'package:graphulus/widgets/paper/graph_paper.dart';
import 'package:graphulus/widgets/sidebar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/expression.dart';
import 'models/expression_provider.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    double scale = 0;

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(children: [
          const SideBar(),
          Expanded(
            child: CartesianGraphPaper(
              scaleX: 20.0,
              scaleY: 20.0,
              lineColor: Colors.grey[800]!,
              lineWidth: 1,
              increment: 2,
              data: [],
            ),
          ),
        ]),
      ),
    );
  }
}
