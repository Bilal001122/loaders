import 'package:flutter/material.dart';

class FirstLoader extends StatefulWidget {
  const FirstLoader({Key? key}) : super(key: key);

  @override
  State<FirstLoader> createState() => _FirstLoaderState();
}

class _FirstLoaderState extends State<FirstLoader>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: -1, end: 1).animate(_controller);
    _controller
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.grey,
                      width: 5,
                    )),
              ),
            ),
            Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Transform(
                  transform: Matrix4.identity()
                    ..translate(_animation.value * 35),
                  child: CustomPaint(
                    painter: _FirstLoaderPainter(),
                    child: const SizedBox(
                      width: 25,
                      height: 15,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.grey,
                      width: 5,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FirstLoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;
    final BorderRadius borderRadius = BorderRadius.circular(15);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
