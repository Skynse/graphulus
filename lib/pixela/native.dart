import 'dart:ffi';
import 'dart:io' as io;

import 'package:ffi/ffi.dart';
import 'package:graphulus/bridge_generated.dart';

import 'package:graphulus/bridge_definitions.dart';

const _base = 'pixela_eval';

final _dylib = io.Platform.isWindows ? '$_base.dll' : './lib$_base.so';
final api = PixelaEvalImpl(io.Platform.isIOS || io.Platform.isMacOS
    ? DynamicLibrary.executable()
    : DynamicLibrary.open(_dylib));

typedef EvalFunc = Double Function(Pointer<Utf8>, Double);
typedef Eval = double Function(Pointer<Utf8>, double);

final lib = DynamicLibrary.open(_dylib);
final eval = lib.lookupFunction<EvalFunc, Eval>('eval');

double evaluate(String expression, double x) {
  final result = eval(expression.toNativeUtf8(), x);
  return result;
}
