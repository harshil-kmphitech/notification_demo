import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:notification_demo/app/utils/helpers/injectable/injectable.dart';

typedef ShouldRebuild<T> = bool Function(T previous, T next);

typedef ValueWidgetBuilder<T> = Widget Function(BuildContext context, T value, Widget? child);

class _Selector0<T, G extends GetxController> extends StatefulWidget {
  _Selector0({
    super.key,
    required this.builder,
    required this.selector,
    ShouldRebuild<T>? shouldRebuild,
    this.child,
    this.id,
  }) : _shouldRebuild = shouldRebuild;

  final Widget? child;

  final Object? id;

  final ValueWidgetBuilder<T> builder;

  final T Function(BuildContext, G) selector;

  final ShouldRebuild<T>? _shouldRebuild;

  final G controller = getIt<G>();

  @override
  State<_Selector0<T, G>> createState() => _Selector0State<T, G>();
}

class _Selector0State<T, G extends GetxController> extends State<_Selector0<T, G>> {
  T? value;
  Widget? cache;
  Widget? oldWidget;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selector(context, widget.controller);

    final shouldInvalidateCache = oldWidget != widget ||
        (widget._shouldRebuild != null && widget._shouldRebuild!(value as T, selected)) ||
        (widget._shouldRebuild == null && !const DeepCollectionEquality().equals(value, selected));
    if (shouldInvalidateCache) {
      value = selected;
      oldWidget = widget;
      cache = Builder(
        builder: (context) => widget.builder(
          context,
          selected,
          widget.child,
        ),
      );
    }
    return cache!;
  }

  @override
  void initState() {
    _subscribeToController();

    super.initState();
  }

  @override
  void dispose() {
    _remove?.call();
    if (widget.id == null) {
      widget.controller.removeListener(getUpdate);
    } else {
      widget.controller.removeListenerId(widget.id!, getUpdate);
    }
    super.dispose();
  }

  void getUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('value', value));
  }

  void _subscribeToController() {
    _remove?.call();
    if (widget.id == null) {
      _remove = widget.controller.addListener(getUpdate);
    } else {
      _remove = widget.controller.addListenerId(widget.id, getUpdate);
    }
  }

  VoidCallback? _remove;
}

class Selector<G extends GetxController, T> extends _Selector0<T, G> {
  Selector({
    super.key,
    super.id,
    required super.builder,
    required super.selector,
    super.shouldRebuild,
    super.child,
  });
}
