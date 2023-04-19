import 'package:flutter/material.dart';
import 'package:graphulus/widgets/paper/graph_paper.dart';
import 'package:graphulus/widgets/sidebar.dart';

void main() {
  runApp(const MainApp());
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(children: [
          const SideBar(),
          Expanded(
            child: InteractiveViewer(
              maxScale: 10,
              onInteractionUpdate: (details) {
                setState(() {
                  scale = details.scale;
                });
              },
              child: CartesianGraphPaper(
                scaleX: 50,
                scaleY: 50,
                lineColor: Colors.grey[800]!,
                lineWidth: 1,
                increment: 2,
                data: [],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
