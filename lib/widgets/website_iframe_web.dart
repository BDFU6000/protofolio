import 'dart:async';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

Widget buildWebsiteIframe({
  required String url,
  required double viewportHeight,
}) =>
    _AutoScrollIframe(url: url, viewportHeight: viewportHeight);

class _AutoScrollIframe extends StatefulWidget {
  const _AutoScrollIframe({required this.url, required this.viewportHeight});

  final String url;
  final double viewportHeight;

  @override
  State<_AutoScrollIframe> createState() => _AutoScrollIframeState();
}

class _AutoScrollIframeState extends State<_AutoScrollIframe> {
  static int _nextViewId = 0;

  late final String _viewType;
  html.IFrameElement? _iframe;
  Timer? _timer;
  double _progress = 0;
  int _direction = 1;

  @override
  void initState() {
    super.initState();
    _viewType = 'torrance-iframe-${_nextViewId++}';

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final container = html.DivElement()
        ..style.width = '100%'
        ..style.height = '${widget.viewportHeight}px'
        ..style.overflow = 'hidden'
        ..style.position = 'relative'
        ..style.borderRadius = '14px';

      final iframe = html.IFrameElement()
        ..src = widget.url
        ..title = 'Website preview'
        ..style.position = 'absolute'
        ..style.left = '0'
        ..style.top = '0'
        ..style.width = '100%'
        ..style.height = '${widget.viewportHeight * 2.4}px'
        ..style.border = 'none';

      container.children.add(iframe);
      _iframe = iframe;
      return container;
    });

    _timer = Timer.periodic(const Duration(milliseconds: 40), (_) {
      final iframe = _iframe;
      if (iframe == null) return;

      _progress += .002 * _direction;
      if (_progress >= 1) {
        _progress = 1;
        _direction = -1;
      } else if (_progress <= 0) {
        _progress = 0;
        _direction = 1;
      }

      final offset = widget.viewportHeight * 1.4 * _progress;
      iframe.style.transform = 'translateY(-${offset.round()}px)';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.viewportHeight,
      child: HtmlElementView(viewType: _viewType),
    );
  }
}
