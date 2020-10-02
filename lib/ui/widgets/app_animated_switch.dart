import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class CustomSwitch extends StatelessWidget {
  final Curve _curve = Curves.easeInOutSine;
  final Duration animDuration;
  final bool isChecked;

  CustomSwitch({
    @required this.isChecked,
    this.animDuration = const Duration(milliseconds: 475),
  });

  @override
  Widget build(BuildContext context) {
    final multiTween = MultiTween<AniProps>()
      ..add(
          AniProps.alignment,
          AlignmentTween(
              begin: Alignment.centerLeft, end: Alignment.centerRight),
          animDuration)
      ..add(AniProps.color, Colors.grey.tweenTo(Colors.green), animDuration)
      ..add(AniProps.rotation, (-2 * pi).tweenTo(0.0), animDuration);

    return CustomAnimation<MultiTweenValues<AniProps>>(
      control: isChecked
          ? CustomAnimationControl.PLAY
          : CustomAnimationControl.PLAY_REVERSE,
      tween: multiTween,
      duration: multiTween.duration,
      curve: _curve,
      builder: (BuildContext context, Widget child,
          MultiTweenValues<AniProps> tweenValue) {
        return _buildSwitch(context, child, tweenValue);
      },
    );
  }

  Widget _buildSwitch(BuildContext context, Widget child,
      MultiTweenValues<AniProps> tweenValue) {
    return Container(
      decoration:
          _toggleButtonOutlineBoxDecoration(tweenValue.get(AniProps.color)),
      width: 60,
      height: 30,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: tweenValue.get(AniProps.alignment),
            child: Transform.rotate(
              angle: tweenValue.get(AniProps.rotation),
              child: AnimatedCrossFade(
                duration: animDuration,
                crossFadeState: isChecked
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Icon(Icons.check_circle,
                    color: tweenValue.get(AniProps.color),
                    size: 24.0,
                    key: UniqueKey()),
                secondChild: Icon(Icons.remove_circle,
                    color: tweenValue.get(AniProps.color),
                    size: 24.0,
                    key: UniqueKey()),
                firstCurve: _curve,
                secondCurve: _curve,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _toggleButtonOutlineBoxDecoration(Color color) => BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 3,
          color: color,
        ),
      );
}

enum AniProps { alignment, rotation, color }

class AppAnimatedToggle extends StatelessWidget {
  final Duration animDuration;
  final String label;
  final bool isChecked;
  final VoidCallback onTap;

  AppAnimatedToggle({Key key,
    @required this.label,
    @required this.isChecked,
    this.animDuration,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: AccentThemeText(
              text: label,
              isBold: true,
            )
          ),
          GestureDetector(
            child: CustomSwitch(isChecked: isChecked),
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}