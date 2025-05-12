import 'package:flutter/material.dart';

class CustomTabIndicator extends Decoration {
  final Color color;
  final double height;
  final double radius;
  final double horizontalPadding;

  const CustomTabIndicator({
    required this.color,
    required this.height,
    required this.radius,
    required this.horizontalPadding,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      color: color,
      height: height,
      radius: radius,
      horizontalPadding: horizontalPadding,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final Color color;
  final double height;
  final double radius;
  final double horizontalPadding;

  _CustomPainter({
    required this.color,
    required this.height,
    required this.radius,
    required this.horizontalPadding,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final double width = configuration.size!.width;
    final double indicatorWidth = width - (horizontalPadding * 2);

    final Rect rect = Offset(
      offset.dx + horizontalPadding,
      offset.dy + configuration.size!.height - height,
    ) & Size(indicatorWidth, height);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(radius)),
      paint,
    );
  }
}