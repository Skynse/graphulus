import 'package:flutter/material.dart';

class Expression {
  Expression({expression, color}) {
    expression = _expression;
    color = _color;
  }

  late String _expression;
  late Color _color;

  get color => _color;

  double evaluate(double x) {
    // test with value of 1 for now
    return 1;
  }
}
