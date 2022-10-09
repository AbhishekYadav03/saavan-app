import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:saavan_app/audio_player/audio_manager.dart';
import 'package:saavan_app/notifier/play_button_notifier.dart';
import 'package:saavan_app/service/service_locator.dart';
import 'package:saavan_app/ui/imports.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            height: 48,
            width: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            ),
          ),
          Center(
            child: Material(
              color: Colors.transparent,
              child: ValueListenableBuilder<ButtonState>(
                valueListenable: getIt<AudioServiceManager>().playButtonNotifier,
                builder: (context, state, child) {
                  switch (state) {
                    case ButtonState.loading:
                      return Container(
                        height: 28,
                        width: 28,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    case ButtonState.playing:
                      return IconButton(
                        onPressed: () {
                          getIt<AudioServiceManager>().pause();
                        },
                        splashRadius: 24,
                        icon: const Icon(
                          Icons.pause_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      );
                    case ButtonState.paused:
                      return IconButton(
                        onPressed: () {
                          getIt<AudioServiceManager>().play();
                        },
                        splashRadius: 24,
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
