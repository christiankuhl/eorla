import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DiceRollTransition extends StatefulWidget {
  final VoidCallback onVideoEnd;
  final DiceAnimation animation;
  const DiceRollTransition({
    required this.onVideoEnd,
    required this.animation,
    super.key,
  });

  @override
  State<DiceRollTransition> createState() => _DiceRollTransitionState();
}

class _DiceRollTransitionState extends State<DiceRollTransition>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late String _asset = 'assets/dice.mp4';

  @override
  void initState() {
    super.initState();
    _asset = super.widget.animation.asset;
    _controller = VideoPlayerController.asset(_asset)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.addListener(() {
      if (_controller.value.position >=
          _controller.value.duration - Duration(milliseconds: 200)) {
        widget.onVideoEnd();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.aspectRatio < 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: isPortrait
                      ? screenSize.width
                      : screenSize.height * _controller.value.aspectRatio,
                  height: isPortrait
                      ? screenSize.width / _controller.value.aspectRatio
                      : screenSize.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

Future<void> fadeDice(
  BuildContext context,
  Widget tgtScreen,
  DiceAnimation animation,
) async {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (_, _, _) => DiceRollTransition(
        animation: animation,
        onVideoEnd: () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, _, _) => tgtScreen,
              transitionsBuilder: (_, animation, _, child) =>
                  FadeTransition(opacity: animation, child: child),
              transitionDuration: const Duration(milliseconds: 200),
            ),
          );
        },
      ),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(milliseconds: 200),
    ),
  );
  await Future.delayed(Duration(milliseconds: 2200));
}

enum DiceAnimation {
  d6('assets/dice6.mp4'),
  d20('assets/dice20.mp4');

  final String asset;

  const DiceAnimation(this.asset);
}
