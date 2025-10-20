import 'package:flutter/material.dart';
import 'package:neigbuy_flutter_app/app/util/zlogger.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocBase {
  final _isLoadingSubject = BehaviorSubject<bool>();
  final _errorSubject = BehaviorSubject<dynamic>();
  Stream<bool> get isLoadingStream => _isLoadingSubject.stream;
  Stream<dynamic> get errorStream => _errorSubject.stream;

  bool get isShowLoading => _isLoadingSubject.valueOrNull ?? false;

  Future dispose() async {
    await _isLoadingSubject.close();
    await _errorSubject.close();
  }

  void isLoading(bool isLoading) {
    if (!_isLoadingSubject.isClosed) _isLoadingSubject.add(isLoading);
  }

  void setError(dynamic error) {
    if (!_errorSubject.isClosed) _errorSubject.add(error);
  }
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BlocProvider<T>>()!.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<BlocBase>> {
  @override
  Widget build(BuildContext context) {
    return _BlocProvider<T>(
      bloc: widget.bloc as T,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    // ZLogger.bloc.info("[BlocBase] dispose...");
    widget.bloc.dispose();
    super.dispose();
  }
}

class _BlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;

  const _BlocProvider({
    Key? key,
    required this.bloc,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProvider old) => true;
}
