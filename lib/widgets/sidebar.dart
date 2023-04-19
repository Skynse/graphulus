import 'package:flutter/material.dart';
import 'package:graphulus/models/expression.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<Expression> expressions = [];
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(milliseconds: 500),
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
                      expressions.add(Expression(
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
              itemCount: expressions.length,
              itemBuilder: (context, index) {
                return SideBarEntry(
                  expression: Expression(
                    expression: 'x^2',
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SideBarEntry extends StatefulWidget {
  const SideBarEntry({super.key, required this.expression});

  final Expression expression;

  @override
  State<SideBarEntry> createState() => _SideBarEntryState();
}

class _SideBarEntryState extends State<SideBarEntry> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.drag_handle),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter an expression',
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
