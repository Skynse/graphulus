import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphulus/pixela/native.dart';

class Expression {
  Expression({
    this.expression = '',
    this.color = Colors.black,
  });

  final String? expression;
  final Color color;

  @override
  String toString() {
    return 'Expression{expression: $expression, color: $color}';
  }

  double eval(double x) {
    return evaluate(expression!, x);
  }
}
