import 'package:flutter/material.dart';

class Expression {
  Expression({expression, color}) {
    _expression = expression;
    _color = color;
  }

  late String _expression;
  late Color _color;
}
