import 'dart:html';
import 'dart:js';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../stub/app_apis_interface.dart';

class AppApis implements AppApisInterface {
  @override
  bool isFullscreen = (document.fullscreenElement != null);

  @override
  final String playerId;

  AppApis(this.playerId);

  @override
  bool toggleFullscreen() {
    var playerDiv = querySelector('#$playerId');
    if (playerDiv != null) {
      return requestFullscreen(playerDiv as DivElement);
    }
    return false;
  }

  bool requestFullscreen(DivElement element) {
    var elem = JsObject.fromBrowserObject(element);

    if (elem.hasProperty("requestFullscreen")) {
      elem.callMethod("requestFullscreen");
      return true;
    } else {
      List<String> vendors = ['moz', 'webkit', 'ms', 'o'];
      for (String vendor in vendors) {
        String vendorFullscreen = "${vendor}RequestFullscreen";
        if (vendor == 'moz') {
          vendorFullscreen = "${vendor}RequestFullScreen";
        }
        if (elem.hasProperty(vendorFullscreen)) {
          elem.callMethod(vendorFullscreen);
          return true;
        }
      }
    }
    return false;
  }

  Widget videoPlayerDocumentBody(BuildContext context) {
    var divTag = DivElement();
    divTag.id = playerId;
    var divElm = querySelector('#${divTag.id}');
    if (divElm == null) {
      document.body!.append(divTag);
    }
    return Container(
      alignment: Alignment.center,
      key: Key('$playerId-container'),
      child: const Text('videoPlayerWidget with document.body.append'),
    );
  }

  Widget videoPlayerHtmlElementView(BuildContext context) {
    var divTag = DivElement();
    divTag.id = playerId;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory('$playerId-view', (int viewId) => divTag);
    return HtmlElementView(key: UniqueKey(), viewType: '$playerId-view');
  }

  @override
  Widget videoPlayerWidget(BuildContext context) {
    // document-body-video-player
    if (playerId.startsWith('document-body-')) {
      return videoPlayerDocumentBody(context);
    }
    return videoPlayerHtmlElementView(context);
  }

  @override
  void dispose(BuildContext context) {
    var divElm = querySelector('#$playerId');
    if (divElm != null) {
      divElm.remove();
    }
  }
}
