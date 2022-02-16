import 'package:flutter/material.dart';

abstract class AppApisInterface {
  String get playerId;

  bool get isFullscreen;

  bool toggleFullscreen();

  Widget videoPlayerWidget(BuildContext context);

  void dispose(BuildContext context);
}
