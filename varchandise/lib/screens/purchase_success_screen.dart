import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessPurchaseScreen extends StatefulWidget {
  const SuccessPurchaseScreen({super.key});

  @override
  State<SuccessPurchaseScreen> createState() => _SuccessPurchaseScreenState();
}

class _SuccessPurchaseScreenState extends State<SuccessPurchaseScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  double percent = 0.0;
  bool isPlaying = false;
  final controller2 =
      ConfettiController(duration: const Duration(milliseconds: 1200));

  changePercent() {
    // 20 frame is enough to beat eye, that's why I used
    // 50 refresh/second to keep animation smooth
    Future.delayed(
      const Duration(milliseconds: 20), // Adjust accordingly.
      () {
        setState(() {
          percent += 0.02; // Adjust accordingly.
        });
        if (percent < 1) {
          changePercent();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..animateTo(1);

    // ** Addition in @mmcdon20 code - Start
    changePercent();
    controller2.play();
    // ** Addition in @mmcdon20 code - End
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7408C2),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pop(context),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        CustomProgressIndicator(
                          value: percent,
                          color: Colors.white,
                          controller: controller,
                          width: 200,
                          height: 200,
                          strokeWidth: 10,
                        ),
                        ConfettiWidget(
                          confettiController: controller2,
                          blastDirectionality: BlastDirectionality.explosive,
                          emissionFrequency: 0.2,
                          numberOfParticles: 20,
                          shouldLoop: false,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Purchased!',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Press Any to Return',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromRGBO(255, 255, 255, 0.65)),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    Key? key,
    required this.color,
    required this.value,
    required this.controller,
    required this.width,
    required this.height,
    required this.strokeWidth,
    this.curve = Curves.linear,
  }) : super(key: key);
  final Color color;
  final double value;
  final AnimationController controller;
  final double width;
  final double height;
  final double strokeWidth;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RotationTransition(
          turns: CurvedAnimation(
            parent: controller,
            curve: curve,
          ),
          child: SizedBox(
            width: width,
            height: height,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              color: color,
              backgroundColor: color.withOpacity(.2),
              value: value,
            ),
          ),
        ),
        const SizedBox(
          width: 200,
          height: 200,
          child: Icon(
            FontAwesomeIcons.check,
            size: 150,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
