import 'dart:ffi';
import 'dart:io' as io;

import 'package:ffi/ffi.dart';
import 'package:graphulus/bridge_generated.dart';

import 'package:graphulus/bridge_definitions.dart';

const _base = 'native';

final _dylib = io.Platform.isWindows ? '$_base.dll' : 'lib$_base.so';
final api = PixelaEvalImpl(io.Platform.isIOS || io.Platform.isMacOS
    ? DynamicLibrary.executable()
    : DynamicLibrary.open(_dylib));

typedef EvalFunc = Double Function(Pointer<Utf8>, Double);
typedef Eval = double Function(Pointer<Utf8>, double);

final dylib = io.Platform.isWindows ? 'mylib.dll' : 'libmylib.so';
final lib = DynamicLibrary.open(dylib);
final eval = lib.lookupFunction<EvalFunc, Eval>('eval');

double result = eval('x^2 + 2x + 1'.toNativeUtf8(), 2);

double evaluate(String expression, double x) {
  final result = eval(expression.toNativeUtf8(), x);
  return result;
}
