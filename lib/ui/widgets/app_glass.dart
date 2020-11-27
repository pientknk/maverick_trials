import 'dart:ui';

import 'package:flutter/material.dart';

/// Creates a frosted glass appearance over the background
/// Content should be put on top of this for full attention
class AppGlass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300].withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
