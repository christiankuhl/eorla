import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DiceRollTransition extends StatefulWidget {
  final DiceAnimation animation;

  const DiceRollTransition({required this.animation, super.key});

  @override
  State<DiceRollTransition> createState() => _DiceRollTransitionState();
}

class _DiceRollTransitionState extends State<DiceRollTransition>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.animation.asset)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        Future.delayed(Duration(seconds: 1), () async {
          await _fadeController.forward();
          if (!_hasNavigated && mounted) {
            _hasNavigated = true;
            if (widget.tgtScreen != null) {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (_, _, _) => widget.tgtScreen!,
                  transitionsBuilder: (_, animation, _, child) =>
                      FadeTransition(opacity: animation, child: child),
                  transitionDuration: Duration(milliseconds: 200),
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
          }
        });
      });

    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(_fadeController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.aspectRatio < 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? FadeTransition(
              opacity: _fadeAnimation,
              child: SizedBox(
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
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

Future<void> fadeDice(
  BuildContext context,
  Widget? tgtScreen,
  DiceAnimation animation,
) async {
  await Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (_, _, _) => DiceRollTransition(
        animation: animation,
        tgtScreen: tgtScreen,
      ),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: Duration(milliseconds: 200),
    ),
  );
}

enum DiceAnimation {
  d6('assets/dice6.mp4'),
  d20('assets/dice20.mp4');

  final String asset;

  const DiceAnimation(this.asset);
}
