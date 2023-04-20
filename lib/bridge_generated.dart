// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.75.1.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import "bridge_definitions.dart";
import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';

import 'dart:ffi' as ffi;

class PixelaEvalImpl implements PixelaEval {
  final PixelaEvalPlatform _platform;
  factory PixelaEvalImpl(ExternalLibrary dylib) =>
      PixelaEvalImpl.raw(PixelaEvalPlatform(dylib));

  /// Only valid on web/WASM platforms.
  factory PixelaEvalImpl.wasm(FutureOr<WasmModule> module) =>
      PixelaEvalImpl(module as ExternalLibrary);
  PixelaEvalImpl.raw(this._platform);
  Future<double?> eval({required String input, double? x, dynamic hint}) {
    var arg0 = _platform.api2wire_String(input);
    var arg1 = _platform.api2wire_opt_box_autoadd_f64(x);
    return _platform.executeNormal(FlutterRustBridgeTask(
      callFfi: (port_) => _platform.inner.wire_eval(port_, arg0, arg1),
      parseSuccessData: _wire2api_opt_box_autoadd_f64,
      constMeta: kEvalConstMeta,
      argValues: [input, x],
      hint: hint,
    ));
  }

  FlutterRustBridgeTaskConstMeta get kEvalConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "eval",
        argNames: ["input", "x"],
      );

  void dispose() {
    _platform.dispose();
  }
// Section: wire2api

  double _wire2api_box_autoadd_f64(dynamic raw) {
    return raw as double;
  }

  double _wire2api_f64(dynamic raw) {
    return raw as double;
  }

  double? _wire2api_opt_box_autoadd_f64(dynamic raw) {
    return raw == null ? null : _wire2api_box_autoadd_f64(raw);
  }
}

// Section: api2wire

@protected
double api2wire_f64(double raw) {
  return raw;
}

@protected
int api2wire_u8(int raw) {
  return raw;
}

// Section: finalizer

class PixelaEvalPlatform extends FlutterRustBridgeBase<PixelaEvalWire> {
  PixelaEvalPlatform(ffi.DynamicLibrary dylib) : super(PixelaEvalWire(dylib));

// Section: api2wire

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_String(String raw) {
    return api2wire_uint_8_list(utf8.encoder.convert(raw));
  }

  @protected
  ffi.Pointer<ffi.Double> api2wire_box_autoadd_f64(double raw) {
    return inner.new_box_autoadd_f64_0(api2wire_f64(raw));
  }

  @protected
  ffi.Pointer<ffi.Double> api2wire_opt_box_autoadd_f64(double? raw) {
    return raw == null ? ffi.nullptr : api2wire_box_autoadd_f64(raw);
  }

  @protected
  ffi.Pointer<wire_uint_8_list> api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }
// Section: finalizer

// Section: api_fill_to_wire
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint

/// generated by flutter_rust_bridge
class PixelaEvalWire implements FlutterRustBridgeWireBase {
  @internal
  late final dartApi = DartApiDl(init_frb_dart_api_dl);

  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  PixelaEvalWire(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  PixelaEvalWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void store_dart_post_cobject(
      ffi.Pointer<
              ffi.NativeFunction<
                  ffi.Bool Function(ffi.Int64, ffi.Pointer<ffi.Void>)>>
          ptr) {
    return _store_dart_post_cobject(ptr as int);
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject =
      _store_dart_post_cobjectPtr.asFunction<void Function(int)>();

  Object get_dart_object(
    int ptr,
  ) {
    return _get_dart_object(
      ptr,
    );
  }

  late final _get_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Handle Function(ffi.UintPtr)>>(
          'get_dart_object');
  late final _get_dart_object =
      _get_dart_objectPtr.asFunction<Object Function(int)>();

  void drop_dart_object(
    int ptr,
  ) {
    return _drop_dart_object(
      ptr,
    );
  }

  late final _drop_dart_objectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.UintPtr)>>(
          'drop_dart_object');
  late final _drop_dart_object =
      _drop_dart_objectPtr.asFunction<void Function(int)>();

  int new_dart_opaque(
    Object handle,
  ) {
    return _new_dart_opaque(
      handle,
    );
  }

  late final _new_dart_opaquePtr =
      _lookup<ffi.NativeFunction<ffi.UintPtr Function(ffi.Handle)>>(
          'new_dart_opaque');
  late final _new_dart_opaque =
      _new_dart_opaquePtr.asFunction<int Function(Object)>();

  int init_frb_dart_api_dl(
    ffi.Pointer<ffi.Void> obj,
  ) {
    return _init_frb_dart_api_dl(
      obj,
    );
  }

  late final _init_frb_dart_api_dlPtr =
      _lookup<ffi.NativeFunction<ffi.IntPtr Function(ffi.Pointer<ffi.Void>)>>(
          'init_frb_dart_api_dl');
  late final _init_frb_dart_api_dl = _init_frb_dart_api_dlPtr
      .asFunction<int Function(ffi.Pointer<ffi.Void>)>();

  void wire_eval(
    int port_,
    ffi.Pointer<wire_uint_8_list> input,
    ffi.Pointer<ffi.Double> x,
  ) {
    return _wire_eval(
      port_,
      input,
      x,
    );
  }

  late final _wire_evalPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, ffi.Pointer<wire_uint_8_list>,
              ffi.Pointer<ffi.Double>)>>('wire_eval');
  late final _wire_eval = _wire_evalPtr.asFunction<
      void Function(
          int, ffi.Pointer<wire_uint_8_list>, ffi.Pointer<ffi.Double>)>();

  ffi.Pointer<ffi.Double> new_box_autoadd_f64_0(
    double value,
  ) {
    return _new_box_autoadd_f64_0(
      value,
    );
  }

  late final _new_box_autoadd_f64_0Ptr =
      _lookup<ffi.NativeFunction<ffi.Pointer<ffi.Double> Function(ffi.Double)>>(
          'new_box_autoadd_f64_0');
  late final _new_box_autoadd_f64_0 = _new_box_autoadd_f64_0Ptr
      .asFunction<ffi.Pointer<ffi.Double> Function(double)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturn(
    WireSyncReturn ptr,
  ) {
    return _free_WireSyncReturn(
      ptr,
    );
  }

  late final _free_WireSyncReturnPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturn)>>(
          'free_WireSyncReturn');
  late final _free_WireSyncReturn =
      _free_WireSyncReturnPtr.asFunction<void Function(WireSyncReturn)>();
}

class _Dart_Handle extends ffi.Opaque {}

class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}
