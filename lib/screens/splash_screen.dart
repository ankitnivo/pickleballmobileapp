import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    // Show poster instantly while video initializes.
    _controller = VideoPlayerController.asset('lib/assests/splash_video.mp4')
      ..initialize().then((_) async {
        // Remove native splash only when we actually have pixels to show.
        FlutterNativeSplash.remove();
        // Autoplay and loop (or keep single play by removing loop)
        await _controller.play();
        setState(() => _ready = true);
      });

    // Navigate when video finishes (single play)
    _controller.addListener(() {
      if (_controller.value.isInitialized &&
          !_controller.value.isPlaying &&
          _controller.value.position >= _controller.value.duration) {
        _goNext();
      }
    });
  }

  void _goNext() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

  Widget poster = SizedBox(
    width: size.width,
    height: size.height,
    child: Image.asset(
      'lib/assests/splash_logo.png',
      //fit: BoxFit.cover,
      height: 250,
      width: 250,
    ),
  );

  Widget video = _controller.value.isInitialized
      ? SizedBox(
          width: size.width,
          height: size.height,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        )
      : const SizedBox.shrink();

  return Scaffold(
    backgroundColor: const Color(00000000),
    body: AnimatedCrossFade(
      duration: const Duration(milliseconds: 350),
      crossFadeState:
          _ready ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: poster,
      secondChild: video,
      // Provide layout hints so both children get consistent constraints
      layoutBuilder: (topChild, topKey, bottomChild, bottomKey) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(key: bottomKey, child: bottomChild),
            Positioned.fill(key: topKey, child: topChild),
          ],
        );
      },
    ),
  );
}

}
