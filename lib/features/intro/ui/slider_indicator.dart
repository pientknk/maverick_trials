import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class SliderIndicator extends StatelessWidget {
  final SliderStatus sliderStatus;
  final VoidCallback onTapped;

  SliderIndicator({Key key, this.sliderStatus, this.onTapped}) :
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      height: 25,
      width: 25,
      child: GestureDetector(
        onTap: onTapped,
        child: ClipPolygon(
          sides: 6,
          rotate: 90.0,
          child: CircleAvatar(
            backgroundColor: _getColorForSliderStatus(sliderStatus),
            child: Container(),
            radius: 25,
          ),
        ),
      ),
    );
  }

  Color _getColorForSliderStatus(SliderStatus sliderStatus){
    Color sliderStatusColor = ThemeColors.sonicSilver;
    switch(sliderStatus){
      case SliderStatus.active:
        sliderStatusColor = ThemeColors.greenSheen;
        break;
      case SliderStatus.completed:
      case SliderStatus.inactive:
      sliderStatusColor = ThemeColors.sonicSilver;
      break;
    }

    return sliderStatusColor;
  }
}

enum SliderStatus { active, inactive, completed }