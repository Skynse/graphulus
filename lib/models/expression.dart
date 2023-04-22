import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:uuid/uuid.dart';

class Expression {
  Expression({
    this.expression = '',
    Color? color,
    String? id,
  })  : id = id ?? Uuid().v4(),
        color = Color.fromARGB(255, Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255));

  String? expression;
  final Color color;
  final String id;

  @override
  String toString() {
    return 'Expression{expression: $expression, color: $color}';
  }

  bool isValid() {
    try {
      final parser = Parser();
      final exp = parser.parse(expression!);
      final context = ContextModel();
      context.bindVariableName('x', Number(0));
      exp.evaluate(EvaluationType.REAL, context);
      return true;
    } catch (e) {
      return false;
    }
  }

  double eval(double x) {
    final parser = Parser();
    final exp = parser.parse(expression!);
    final context = ContextModel();
    // add support for x and y both
    context.bindVariableName('x', Number(x));

    return exp.evaluate(EvaluationType.REAL, context);
  }

  Expression copyWith({
    String? id,
    String? expression,
    Color? color,
  }) {
    return Expression(
      id: id ?? this.id,
      expression: expression ?? this.expression,
      color: color ?? this.color,
    );
  }
}
