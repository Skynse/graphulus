import 'package:flutter/foundation.dart';
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
    return RepaintBoundary(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // container for the expressions on top right corner

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: InteractiveViewer(
                scaleFactor: 1000,
                child: CustomPaint(
                  painter: CartesianPaper(
                    scaleX: _scaleX,
                    scaleY: _scaleY,
                    lineColor: widget.lineColor,
                    lineWidth: widget.lineWidth,
                    increment: widget.increment,
                    data: data,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: data.isNotEmpty,
              child: Positioned(
                top: 10,
                right: 20,
                child: Container(
                  width: 200,
                  height: ref.watch(expressionProvider.notifier).state.length *
                      50.0,
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
      ),
    );
  }
}

class CartesianPaper extends CustomPainter {
  CartesianPaper({
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
  bool shouldRepaint(CartesianPaper oldDelegate) {
    return !listEquals(data, oldDelegate.data);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;
    final halfWidth = width / 2;
    final halfHeight = height / 2;

    // draw the grid
    // painting starts from top left corner
    // so we need to translate the canvas to the center
    // because the sidebar takes up 200 pixels of space on the left,
    // we need to translate the canvas by 200 + half the width of the canvas
    canvas.translate(centerX, centerY);

    // draw the grid lines
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth;

    void _drawAxes() {
      // draw the x-axis
      canvas.drawLine(
        Offset(-halfWidth, 0),
        Offset(halfWidth, 0),
        paint,
      );

      // draw the y-axis
      canvas.drawLine(
        Offset(0, -halfHeight),
        Offset(0, halfHeight),
        paint,
      );

      // draw the x-axis ticks
      for (var i = 0.0; i < halfWidth; i += scaleX) {
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

      // draw the grid lines
      paint.strokeWidth = 0.5;
      paint.color = Colors.grey[300]!;
      for (var i = 0.0; i < halfWidth; i += scaleX) {
        // draw the positive grid lines
        canvas.drawLine(
          Offset(i.toDouble(), -halfHeight),
          Offset(i.toDouble(), halfHeight),
          paint,
        );

        // draw the negative grid lines
        canvas.drawLine(
          Offset(-i.toDouble(), -halfHeight),
          Offset(-i.toDouble(), halfHeight),
          paint,
        );
      }

      for (var i = 0.0; i < halfHeight; i += scaleY) {
        // draw the positive grid lines
        canvas.drawLine(
          Offset(-halfHeight, i.toDouble()),
          Offset(halfWidth, i.toDouble()),
          paint,
        );

        // draw the negative grid lines
        canvas.drawLine(
          Offset(-halfWidth, -i.toDouble()),
          Offset(halfWidth, -i.toDouble()),
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
      for (var i = 0.0; i < halfWidth; i += scaleX) {
        // increments of 2
        textPainter.text = TextSpan(
          text: (i / scaleX * increment).round().toString(),
          style: TextStyle(
            color: lineColor,
            fontSize: 10,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(i.toDouble() - 5, 5));

        textPainter.text = TextSpan(
          text: (-i / scaleX * increment).round().toString(),
          style: TextStyle(
            color: lineColor,
            fontSize: 10,
          ),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(-i.toDouble() - 5, 5));
      }

      // draw the y-axis labels
      for (var i = 0.0; i < halfHeight; i += scaleY) {
        textPainter.text = TextSpan(
          text: (i / scaleY * increment).round().toString(),
          style: TextStyle(
            color: lineColor,
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
          text: (-i / scaleY * increment).round().toString(),
          style: TextStyle(
            color: lineColor,
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
      for (var idx = 0; idx < data.length; idx++) {
        final expression = data[idx];
        if (!expression.isValid()) {
          continue;
        }
        final color = expression.color;
        final paint = Paint()
          ..color = color
          ..strokeWidth = 2;

        // draw the expression
        final increment = scaleX / 8; // or some smaller value
        for (var i = -halfWidth; i < halfWidth; i += increment) {
          final x = i / scaleX * increment;
          final y = expression.eval(x);
          if (!(i - increment).isNaN && !x.isNaN && !y.isNaN) {
            canvas.drawLine(
              Offset(
                  (i - increment) / scaleX * increment * scaleX,
                  -(expression.eval((i - increment) / scaleX * increment) *
                      scaleY)),
              Offset(x * scaleX, -y * scaleY),
              paint,
            );
          }
        }
      }
    }

    // clear canvas
    _drawAxes();
    _drawLabels();
    _drawPlots();
  }
}
