import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// This Text Widget is for text that should stand out above the rest.
///
/// i.e. a significant button's label
///
/// The text is capitalized, and the style is bold with a larger font size
class ImportantText extends StatelessWidget {
  final String text;
  final Color textColor;

  ImportantText({Key key,
    @required this.text,
    this.textColor,
  })
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.oswald(
        height: 1.2,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
        /*
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: textColor,
      ),

         */
    );
  }
}

/// This Text Widget is for smaller text where the content is less important.
///
/// The style is a smaller font weight and size
class SecondaryText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  SecondaryText({Key key, @required this.text, this.textAlign = TextAlign.start})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyTextTheme = Theme.of(context).accentTextTheme.bodyText2;
    return Text(text,
      style: GoogleFonts.oswald(
        textStyle: TextStyle(
          fontWeight: bodyTextTheme.fontWeight,
          fontSize: 16,
        ),
      ),
      textAlign: textAlign,
    );
  }
}

class AccentThemeText extends StatelessWidget {
  final String text;
  final bool isBold;

  AccentThemeText({Key key, @required this.text, this.isBold = false})
    : assert(text != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.oswald(

        textStyle: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: 15,
        ),
      ),
    );
  }
}

class ButtonThemeText extends StatelessWidget {
  final String text;
  final bool isBold;

  ButtonThemeText({@required this.text, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: GoogleFonts.lato(
        textStyle: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
