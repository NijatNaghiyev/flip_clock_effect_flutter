import 'package:flutter/material.dart';

class FlipClockCardItem extends StatelessWidget {
  const FlipClockCardItem({
    super.key,
    required this.isTop,
    required this.content,
    required this.animation,
    this.canFlip = false,
  });

  final bool isTop;
  final int content;
  final double animation;
  final bool canFlip;

  @override
  Widget build(BuildContext context) {
    double sliderDistance = -107;

    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius:
            isTop
                ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )
                : const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
      ),
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      padding: EdgeInsets.zero,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            top: isTop ? null : sliderDistance,
            bottom: isTop ? sliderDistance : null,
            child: Transform.flip(
              flipY: isTop && animation > 0.5 && canFlip,
              child: Text(
                content.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  fontSize: 150,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
