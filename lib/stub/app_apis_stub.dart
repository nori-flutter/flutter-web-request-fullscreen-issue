import 'package:flutter/material.dart';
import 'app_apis_interface.dart';

class AppApis implements AppApisInterface {
  @override
  bool get isFullscreen => false;

  @override
  final String playerId;

  AppApis(this.playerId);

  @override
  bool toggleFullscreen() {
    return false;
  }

  @override
  Widget videoPlayerWidget(BuildContext context) {
    return Container(key: Key('$playerId-container'));
  }

  @override
  void dispose(BuildContext context) {}
}
