import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class AppAnimatedIconButton extends StatelessWidget {
  final Duration animDuration;
  final double startingSize;
  final double endingSize;
  final VoidCallback onPressed;
  final Widget icon;
  final bool runAnimation;

  AppAnimatedIconButton({
    @required this.onPressed,
    @required this.icon,
    @required this.startingSize,
    @required this.endingSize,
    this.runAnimation = false,
    this.animDuration = const Duration(milliseconds: 575)});

  @override
  Widget build(BuildContext context) {
    print('AppAnimatedIconButton should run animation? $runAnimation');
    if(runAnimation == null || !runAnimation){
      return IconButton(
        key: UniqueKey(),
        iconSize: startingSize,
        onPressed: onPressed,
        icon: icon,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      );
    }

    Color iconAccentColor = Theme.of(context).accentIconTheme.color;
    Color iconColor = Theme.of(context).iconTheme.color;

    Duration halfAnimDuration = (animDuration.inMilliseconds ~/ 2).milliseconds;
    final multiTween = MultiTween<AniProps>()
      ..add(AniProps.color, iconAccentColor.tweenTo(iconColor), halfAnimDuration)
      ..add(AniProps.color, iconColor.tweenTo(iconAccentColor), halfAnimDuration)
      ..add(AniProps.rotation, (-2 * pi).tweenTo(0.0), animDuration)
      ..add(AniProps.size, startingSize.tweenTo(endingSize), halfAnimDuration)
      ..add(AniProps.size, endingSize.tweenTo(startingSize), halfAnimDuration);

    return CustomAnimation<MultiTweenValues<AniProps>>(
      control: CustomAnimationControl.PLAY_FROM_START,
      tween: multiTween,
      duration: multiTween.duration,
      curve: Curves.easeInOutSine,
      builder: (BuildContext context, Widget child, MultiTweenValues<AniProps> tweenValue){
        return _buildAnimatedIcon(tweenValue);
      },
    );
  }

  Widget _buildAnimatedIcon(MultiTweenValues<AniProps> tweenValue){
    return Transform.rotate(
      angle: tweenValue.get(AniProps.rotation),
      child: AnimatedCrossFade(
        duration: animDuration,
        crossFadeState: CrossFadeState.showFirst,
        firstChild: IconButton(
          key: UniqueKey(),
          color: tweenValue.get(AniProps.color),
          iconSize: tweenValue.get(AniProps.size),
          onPressed: onPressed,
          icon: icon,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        firstCurve: Curves.easeInOutSine,
        secondChild: IconButton(
          key: UniqueKey(),
          color: tweenValue.get(AniProps.color),
          iconSize: tweenValue.get(AniProps.size),
          onPressed: onPressed,
          icon: icon,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        secondCurve: Curves.easeInOutSine,
      ),
    );
  }
}

enum AniProps {
  color,
  rotation,
  size,
}
