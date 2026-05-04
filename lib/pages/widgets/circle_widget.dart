import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle({super.key, required this.dimension});

  final double dimension;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white10),
    );
  }
}