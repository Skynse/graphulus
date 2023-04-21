import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphulus/models/expression_provider.dart';

import '../../models/expression.dart';

class CartesianGraphPaper extends ConsumerStatefulWidget {
  CartesianGraphPaper({
    super.key,
    this.scaleX = 1.0,
    this.scaleY = 1.0,
    this.lineColor = Colors.black,
    this.lineWidth = 1,
    this.increment = 2,
    this.data = const [],
  });

  final double scaleX;
  final double scaleY;
  final Color lineColor;
  final double lineWidth;
  final double increment;
  final List<Expression> data;

  @override
  ConsumerState<CartesianGraphPaper> createState() =>
      _CartesianGraphPaperState();
}

class _CartesianGraphPaperState extends ConsumerState<CartesianGraphPaper> {
  double _scaleX = 50.0;
  double _scaleY = 50.0;
  @override
  Widget build(BuildContext context) {
    List<Expression> data = ref.watch(expressionProvider);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // container for the expressions on top right corner

          InteractiveViewer(
            scaleFactor: 1000,
            child: CartesianPaper(
              scaleX: _scaleX,
              scaleY: _scaleY,
              lineColor: widget.lineColor,
              lineWidth: widget.lineWidth,
              increment: widget.increment,
              data: data,
            ),
          ),
          Visibility(
            visible: data.isNotEmpty,
            child: Positioned(
              top: 10,
              right: 20,
              child: Container(
                width: 200,
                height:
                    ref.watch(expressionProvider.notifier).state.length * 50.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (data[index].isValid()) {
                      return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[300]!,
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(ref
                                .watch(expressionProvider.notifier)
                                .state[index]
                                .expression!),
                            leading:
                                Icon(Icons.circle, color: data[index].color),
                          ));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartesianPaper extends LeafRenderObjectWidget {
  CartesianPaper({
    super.key,
    this.scaleX = 1.0,
    this.scaleY = 1.0,
    this.lineColor = Colors.black,
    this.lineWidth = 1,
    this.increment = 2,
    this.data = const [],
  });

  final double scaleX;
  final double scaleY;
  final Color lineColor;
  final double lineWidth;
  final double increment;
  final List<Expression> data;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CartesianPaperRenderObject(
      scaleX: scaleX,
      scaleY: scaleY,
      lineColor: lineColor,
      lineWidth: lineWidth,
      increment: increment,
      data: data,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, CartesianPaperRenderObject renderObject) {
    renderObject._data = data;
    renderObject._scaleX = scaleX;
    renderObject._scaleY = scaleY;
    renderObject._lineColor = lineColor;
    renderObject._lineWidth = lineWidth;
  }
}

class CartesianPaperRenderObject extends RenderBox {
  CartesianPaperRenderObject({
    required double scaleX,
    required double scaleY,
    required Color lineColor,
    required double lineWidth,
    required double increment,
    required List<Expression> data,
  }) {
    _scaleX = scaleX;
    _scaleY = scaleY;
    _lineColor = lineColor;
    _lineWidth = lineWidth;
    _increment = increment;
    _data = data;
  }

  late double _scaleX;
  late double _scaleY;
  late Color _lineColor;
  late double _lineWidth;
  late List<Expression> _data;
  late double _increment;

  @override
  void performLayout() {
    // get the size of the parent
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    canvas.save();

    // draw the grid
    // painting starts from top left corner
    // so we need to translate the canvas to the center
    // because the sidebar takes up 200 pixels of space on the left,
    // we need to translate the canvas by 200 + half the width of the canvas
    canvas.translate(400 + size.width / 2, size.height / 2);

    // draw the grid lines
    final paint = Paint()
      ..color = _lineColor
      ..strokeWidth = _lineWidth;

    void _drawAxes() {
      // draw the x-axis
      canvas.drawLine(
        Offset(-size.width / 2, 0),
        Offset(size.width / 2, 0),
        paint,
      );

      // draw the y-axis
      canvas.drawLine(
        Offset(0, -size.height / 2),
        Offset(0, size.height / 2),
        paint,
      );

      // draw the x-axis ticks
      for (var i = 0.0; i < size.width / 2; i += _scaleX) {
        // draw the positive ticks
        canvas.drawLine(
          Offset(i.toDouble(), 0),
          Offset(i.toDouble(), 5),
          paint,
        );

        // draw the negative ticks
        canvas.drawLine(
          Offset(-i.toDouble(), 0),
          Offset(-i.toDouble(), 5),
          paint,
        );
      }

      // draw the y-axis ticks

      for (var i = 0.0; i < size.height / 2; i += _scaleY) {
        // draw the positive ticks
        canvas.drawLine(
          Offset(0, i.toDouble()),
          Offset(5, i.toDouble()),
          paint,
        );

        // draw the negative ticks
        canvas.drawLine(
          Offset(0, -i.toDouble()),
          Offset(5, -i.toDouble()),
          paint,
        );
      }

      // draw the grid lines
      paint.strokeWidth = 0.5;
      paint.color = Colors.grey[300]!;
      for (var i = 0.0; i < size.width / 2; i += _scaleX) {
        // draw the positive grid lines
        canvas.drawLine(
          Offset(i.toDouble(), -size.height / 2),
          Offset(i.toDouble(), size.height / 2),
          paint,
        );

        // draw the negative grid lines
        canvas.drawLine(
          Offset(-i.toDouble(), -size.height / 2),
          Offset(-i.toDouble(), size.height / 2),
          paint,
        );
      }

      for (var i = 0.0; i < size.height / 2; i += _scaleY) {
        // draw the positive grid lines
        canvas.drawLine(
          Offset(-size.width / 2, i.toDouble()),
          Offset(size.width / 2, i.toDouble()),
          paint,
        );

        // draw the negative grid lines
        canvas.drawLine(
          Offset(-size.width / 2, -i.toDouble()),
          Offset(size.width / 2, -i.toDouble()),
          paint,
        );
      }
    }

    // draw labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    void _drawLabels() {
      // draw the x-axis labels
      for (var i = 0.0; i < size.width / 2; i += _scaleX) {
        // increments of 2
        textPainter.text = TextSpan(
          text: (i / _scaleX * _increment).round().toString(),
          style: TextStyle(
            color: _lineColor,
            fontSize: 10,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(i.toDouble() - 5, 5));

        textPainter.text = TextSpan(
          text: (-i / _scaleX * _increment).round().toString(),
          style: TextStyle(
            color: _lineColor,
            fontSize: 10,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(-i.toDouble() - 5, 5));
      }

      // draw the y-axis labels
      for (var i = 0.0; i < size.height / 2; i += _scaleY) {
        textPainter.text = TextSpan(
          text: (i / _scaleY * _increment).round().toString(),
          style: TextStyle(
            color: _lineColor,
            shadows: const <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 3.0,
                color: Colors.white,
              ),
            ],
            fontSize: 10,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(-10, i.toDouble() - 5));

        textPainter.text = TextSpan(
          text: (-i / _scaleY * _increment).round().toString(),
          style: TextStyle(
            color: _lineColor,
            fontSize: 10,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(-10, -i.toDouble() - 5));
      }
    }

    void _drawPlots() {
      // !NOTE: Draw expressions
      // draw the expressions
      for (var idx = 0; idx < _data.length; idx++) {
        final expression = _data[idx];
        if (!expression.isValid()) {
          continue;
        }
        final color = expression.color;
        final paint = Paint()
          ..color = color
          ..strokeWidth = 2;

        // draw the expression
        final increment = _scaleX / 20; // or some smaller value
        for (var i = -size.width / 2; i < size.width / 2; i += increment) {
          final x = i / _scaleX * _increment;
          final y = expression.eval(x);

          canvas.drawLine(
            Offset(
                (i - increment) / _scaleX * _increment * _scaleX,
                -(expression.eval((i - increment) / _scaleX * _increment) *
                    _scaleY)),
            Offset(x * _scaleX, -y * _scaleY),
            paint,
          );
        }
      }
    }

    // clear canvas
    _drawAxes();
    _drawLabels();
    _drawPlots();
  }
}
