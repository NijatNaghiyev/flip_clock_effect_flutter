import 'dart:async';

import 'package:flip_clock_effect_flutter/mixins/flip_clock_effect_mixin.dart';
import 'package:flip_clock_effect_flutter/widgets/flip_clock_card.dart';
import 'package:flutter/cupertino.dart';

class FlipClockEffectScreen extends StatefulWidget {
  const FlipClockEffectScreen({super.key});

  @override
  State<FlipClockEffectScreen> createState() => _FlipClockEffectScreenState();
}

class _FlipClockEffectScreenState extends State<FlipClockEffectScreen>
    with SingleTickerProviderStateMixin, FlipClockEffectMixin {
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          clockDuration += Duration(seconds: 1);
          if (clockDuration.inSeconds > 59) {
            clockDuration = Duration.zero;
          }

          controller.reset();
        }
      });

    timer = Timer.periodic(duration, (timer) async {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///? First Card
              SizedBox(
                height: 260,
                width: 130,
                child: Stack(
                  children: [
                    Positioned(
                      top: 130,
                      child: FlipClockCard(
                        clockDuration: clockDuration,
                        isTop: false,
                        content: clockItem(1),
                        animation: controller.value,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: FlipClockCard(
                        clockDuration: clockDuration,
                        isTop: true,
                        content: clockItem(1),
                        animation: controller.value,
                        isMinute: true,
                      ),
                    ),
                  ],
                ),
              ),

              ///? Second Card
              SizedBox(
                height: 260,
                width: 130,
                child: Stack(
                  children: [
                    Positioned(
                      top: 130,
                      child: FlipClockCard(
                        clockDuration: clockDuration,
                        isTop: false,
                        content: clockItem(0),
                        animation: controller.value,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: FlipClockCard(
                        clockDuration: clockDuration,
                        isTop: true,
                        content: clockItem(0),
                        animation: controller.value,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
