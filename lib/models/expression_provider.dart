import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphulus/models/expression.dart';

class ExpressionNotifier extends Notifier<List<Expression>> {
  void add(Expression expression) {
    state = [...state, expression];
  }

  void remove(Expression expression) {
    state = state.where((e) => e != expression).toList();
  }

  void clear() {
    state = [];
  }

  void update(Expression expression) {
    state = state.map((e) => e == expression ? expression : e).toList();
  }

  @override
  List<Expression> build() {
    return [];
  }
}

final expressionProvider =
    NotifierProvider<ExpressionNotifier, List<Expression>>(
        ExpressionNotifier.new);
