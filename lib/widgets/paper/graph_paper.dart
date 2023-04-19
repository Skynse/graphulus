import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../models/expression.dart';

class CartesianGraphPaper extends StatefulWidget {
  CartesianGraphPaper({
    super.key,
    this.scaleX = 1,
    this.scaleY = 1,
    this.lineColor = Colors.black,
    this.lineWidth = 1,
    this.increment = 2,
    this.data = const [],
  });

  final int scaleX;
  final int scaleY;
  final Color lineColor;
  final double lineWidth;
  final double increment;
  final List<Expression> data;

  @override
  State<CartesianGraphPaper> createState() => _CartesianGraphPaperState();
}

class _CartesianGraphPaperState extends State<CartesianGraphPaper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CartesianPaper(
        scaleX: widget.scaleX,
        scaleY: widget.scaleY,
        lineColor: widget.lineColor,
        lineWidth: widget.lineWidth,
        increment: widget.increment,
        data: widget.data,
      ),
    );
  }
}

class CartesianPaper extends LeafRenderObjectWidget {
  CartesianPaper({
    super.key,
    this.scaleX = 1,
    this.scaleY = 1,
    this.lineColor = Colors.black,
    this.lineWidth = 1,
    this.increment = 2,
    this.data = const [],
  });

  final int scaleX;
  final int scaleY;
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
    required int scaleX,
    required int scaleY,
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

  late int _scaleX;
  late int _scaleY;
  late Color _lineColor;
  late double _lineWidth;
  late List<Expression> _data;
  late double _increment;

  @override
  void performLayout() {
    // fit in any size

    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    canvas.save();

    // draw the grid
    // painting starts from top left corner
    // so we need to translate the canvas to the center
    canvas.translate(size.width / 2, size.height / 2);

    // draw the grid lines
    final paint = Paint()
      ..color = _lineColor
      ..strokeWidth = _lineWidth;

    // draw the vertical lines
    for (var i = 0; i < size.width / 2; i += _scaleX) {
      if (i % 2 != 0) {
        paint.strokeWidth = _lineWidth;
      } else {
        paint.strokeWidth = _lineWidth / 4;
      }
      canvas.drawLine(Offset(i.toDouble(), -size.height / 2),
          Offset(i.toDouble(), size.height / 2), paint);
      canvas.drawLine(Offset(-i.toDouble(), -size.height / 2),
          Offset(-i.toDouble(), size.height / 2), paint);
    }

    // draw the horizontal lines
    for (var i = 0; i < size.height / 2; i += _scaleY) {
      // even odd thickness for better visibility
      if (i % 2 != 0) {
        paint.strokeWidth = _lineWidth;
      } else {
        paint.strokeWidth = _lineWidth / 4;
      }
      canvas.drawLine(Offset(-size.width / 2, i.toDouble()),
          Offset(size.width / 2, i.toDouble()), paint);
      canvas.drawLine(Offset(-size.width / 2, -i.toDouble()),
          Offset(size.width / 2, -i.toDouble()), paint);
    }

    // draw the axes
    paint.strokeWidth = 2;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), paint);

    //draw arrows
    canvas.drawLine(
        Offset(size.width / 2 - 10, 10), Offset(size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(size.width / 2 - 10, -10), Offset(size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(-size.width / 2 + 10, 10), Offset(-size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(-size.width / 2 + 10, -10), Offset(-size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(10, size.height / 2 - 10), Offset(0, size.height / 2), paint);

    canvas.drawLine(
        Offset(-10, size.height / 2 - 10), Offset(0, size.height / 2), paint);
    canvas.drawLine(
        Offset(10, -size.height / 2 + 10), Offset(0, -size.height / 2), paint);
    canvas.drawLine(
        Offset(-10, -size.height / 2 + 10), Offset(0, -size.height / 2), paint);

    // draw labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // draw the x-axis labels
    for (var i = 0; i < size.width / 2; i += _scaleX) {
      // increments of 2
      textPainter.text = TextSpan(
        text: (i / _scaleX * _increment).toString(),
        style: TextStyle(
          color: _lineColor,
          fontSize: 10,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(i.toDouble() - 5, 5));

      textPainter.text = TextSpan(
        text: (-i / _scaleX * _increment).toString(),
        style: TextStyle(
          color: _lineColor,
          fontSize: 10,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-i.toDouble() - 5, 5));
    }

    // draw the y-axis labels
    for (var i = 0; i < size.height / 2; i += _scaleY) {
      textPainter.text = TextSpan(
        text: (i / _scaleY * _increment).toString(),
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
        text: (-i / _scaleY * _increment).toString(),
        style: TextStyle(
          color: _lineColor,
          fontSize: 10,
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-10, -i.toDouble() - 5));
    }
  }
}
