import 'package:flutter/material.dart';

Widget buildWebsiteIframe({
  required String url,
  required double viewportHeight,
}) {
  return SizedBox(
    height: viewportHeight,
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1424),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x33FFFFFF)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Live preview is available in the web version.\n$url',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFFB8C4D9), fontSize: 12),
          ),
        ),
      ),
    ),
  );
}
