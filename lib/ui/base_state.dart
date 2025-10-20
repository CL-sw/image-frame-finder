import 'package:flutter/material.dart';
import 'package:neigbuy_flutter_app/app/application.dart';
import 'package:neigbuy_flutter_app/ui/theme/theme_ngb.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool _animationCompleted = false;

  final _willPopSubject = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get willPopStream => _willPopSubject.stream;

  void onNavigationPop({bool popCurrent = true}) {
    _willPopSubject.add(true);
    popCurrent ? Application.instance.router.pop(context) : null;
  }

  bool get wrapInScaffold => true;

  bool get overrideWillPop => false;

  Color get backgroundColor => CustomColor.white;

  PreferredSizeWidget? appBar(BuildContext context) => null;

  Widget mainContentWidget(BuildContext context) =>
      throw UnimplementedError("SubClass should implement mainContentWidget()");

  @override
  Widget build(BuildContext context) {
    return wrapInScaffold
        ? Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(context),
      body: PopScope(
        onPopInvoked: (didPop) async {
          _willPopSubject.add(overrideWillPop);
        },
        child: _bodyWidget(context),
      ),
    )
        : _bodyWidget(context);
  }

  Widget _bodyWidget(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route != null && !_animationCompleted) {
      void handler(status) {
        if (status == AnimationStatus.completed) {
          route.animation?.removeStatusListener(handler);
          setState(() {
            _animationCompleted = true;
          });
        }
      }
      route.animation?.addStatusListener(handler);
    }

    return StreamBuilder<bool>(
      initialData: false,
      stream: willPopStream,
      builder: (context, snapshot) {
        final willPop = snapshot.requireData;

        // debugPrint("[BaseState] willPopStream overrideWillPop: $overrideWillPop");
        // debugPrint("[BaseState] willPopStream _animationCompleted: $_animationCompleted");

        return willPop || !_animationCompleted
            ? const SizedBox.shrink()
            : mainContentWidget(context);
      },
    );
  }
}