import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:graphulus/pixela/native.dart';
import 'package:graphulus/models/expression.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    Expression exp = Expression(expression: "x^2", color: Colors.red);
    expect(eval(exp.toString().toNativeUtf8(), 2), 4);
  });
}
