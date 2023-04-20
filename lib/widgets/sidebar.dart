import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphulus/models/expression.dart';

import '../models/expression_provider.dart';

class SideBar extends ConsumerStatefulWidget {
  const SideBar({super.key});

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 400,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      duration: const Duration(milliseconds: 500),
      child: Column(
        children: [
          Container(
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      ref.read(expressionProvider.notifier).add(Expression(
                            expression: 'x^2',
                            color: Colors.red,
                          ));
                    });
                  },
                  icon: Icon(Icons.add),
                ),
                Row(
                  children: [
                    // undo button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.undo),
                    ),
                    // redo button
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.redo),
                    ),
                  ],
                )
              ],
            ),
          ),

          // expression list
          Expanded(
            child: ListView.builder(
              itemCount: ref.read(expressionProvider.notifier).state.length,
              itemBuilder: (context, index) {
                return SideBarEntry(
                  expression:
                      ref.read(expressionProvider.notifier).state[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SideBarEntry extends ConsumerWidget {
  const SideBarEntry({super.key, required this.expression});

  final Expression expression;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.drag_handle),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'y = x^2',
              ),
              onChanged: (value) {
                ref.read(expressionProvider.notifier).update(Expression(
                      expression: value,
                      color: Colors.greenAccent,
                    ));
              },
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(expressionProvider.notifier).remove(expression);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
