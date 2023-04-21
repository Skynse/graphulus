import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphulus/models/expression.dart';
import 'dart:async';
import '../models/expression_provider.dart';

class SideBar extends ConsumerStatefulWidget {
  const SideBar({super.key});

  @override
  ConsumerState<SideBar> createState() => _SideBarState();
}

class _SideBarState extends ConsumerState<SideBar> {
  @override
  Widget build(BuildContext context) {
    final expressions = ref.watch(expressionProvider);
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
                    ref.read(expressionProvider.notifier).add(Expression(
                          expression: '',
                          color: Colors.red,
                        ));
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

class SideBarEntry extends ConsumerStatefulWidget {
  SideBarEntry({super.key, required this.expression});

  Expression expression;

  @override
  ConsumerState<SideBarEntry> createState() => _SideBarEntryState();
}

class _SideBarEntryState extends ConsumerState<SideBarEntry> {
  TextEditingController controller = TextEditingController();

  StreamController<String> _textController = StreamController<String>();

  Timer _debounce = Timer(Duration.zero, () {});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.circle, color: widget.expression.color),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Expression',
              ),
              onChanged: (value) {
                ref.read(expressionProvider.notifier).update(
                      widget.expression.id,
                      value,
                    );
              },
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(expressionProvider.notifier).remove(widget.expression);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
