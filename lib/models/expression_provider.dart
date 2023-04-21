import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphulus/models/expression.dart';

class ExpressionNotifier extends StateNotifier<List<Expression>> {
  ExpressionNotifier() : super([]);

  int idCounter = 0;

  void add(Expression expression) {
    state = [...state, expression];
  }

  void remove(Expression expression) {
    state = state.where((e) => e != expression).toList();
  }

  void clear() {
    state = [];
  }

  void update(String id, String value) {
    /** 
    final updated = expression.copyWith(expression: updatedExpression);
    state = state.map((e) => e == expression ? updated : e).toList();
    */

// don't make a new copy, just update the state with id
// do not use copyWith otherwise the color will change
    state = state.map((e) {
      if (e.id == id) {
        e.expression = value;
      }
      return e;
    }).toList();
  }

  @override
  List<Expression> build() {
    return [];
  }
}

final expressionProvider =
    StateNotifierProvider<ExpressionNotifier, List<Expression>>(
        (ref) => ExpressionNotifier());
