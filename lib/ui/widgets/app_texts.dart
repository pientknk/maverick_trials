import 'package:flutter/material.dart';

/// This Text Widget is for text that should stand out above the rest.
///
/// i.e. a significant button's label
///
/// The text is capitalized, and the style is bold with a larger font size
class ImportantText extends StatelessWidget {
  final String text;

  ImportantText({Key key, @required this.text})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

/// This Text Widget is for smaller text where the content is less important.
///
/// The style is a smaller font weight and size
class SecondaryText extends StatelessWidget {
  final String text;

  SecondaryText({Key key, @required this.text})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
    );
  }
}
