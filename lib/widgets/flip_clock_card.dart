import 'dart:math';

import 'package:flip_clock_effect_flutter/widgets/flip_clock_card_item.dart';
import 'package:flutter/material.dart';

class FlipClockCard extends StatefulWidget {
  const FlipClockCard({
    super.key,
    required this.isTop,
    required this.content,
    required this.animation,
    this.isMinute = false,
    required this.clockDuration,
  });
  final bool isTop;
  final int content;
  final double animation;
  final bool isMinute;
  final Duration clockDuration;

  @override
  State<FlipClockCard> createState() => _FlipClockCardState();
}

class _FlipClockCardState extends State<FlipClockCard> {
  bool canNotRotate = true;

  @override
  void didUpdateWidget(covariant FlipClockCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    canNotRotate =
        widget.isMinute && (widget.clockDuration.inSeconds % 10) != 9;
  }

  @override
  Widget build(BuildContext context) {
    double rotateDegree = pi * widget.animation;

    if (!widget.isTop) {
      rotateDegree = 0;
    }

    if (canNotRotate) {
      rotateDegree = 0;
    }

    return RepaintBoundary(
      child: Stack(
        children: [
          Visibility(
            visible: widget.isTop,
            child: FlipClockCardItem(
              animation: widget.animation,
              isTop: widget.isTop,
              content: widget.animation < 0.3 ? widget.content : contentPlus(),
            ),
          ),
          Transform(
            alignment: Alignment.bottomCenter,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.0005)
                  ..rotateX(rotateDegree),
            child: FlipClockCardItem(
              canFlip: !canNotRotate && true,
              animation: widget.animation,
              isTop: widget.isTop,
              content:
                  widget.isTop
                      ? widget.animation < 0.5
                          ? widget.content
                          : contentPlus()
                      : widget.content,
            ),
          ),
        ],
      ),
    );
  }

  int contentPlus() {
    if (canNotRotate) {
      return widget.content;
    }
    return ((widget.content) + 1) == 10 ? 0 : (widget.content + 1);
  }
}
