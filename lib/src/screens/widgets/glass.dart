import 'dart:ui';
import 'package:flutter/material.dart';

class Glass extends StatelessWidget {

  final Widget child;
  final double borderRadius;

  const Glass ({Key? key,
    required this.child,
    this.borderRadius = 12
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.2),
            borderRadius: BorderRadius.circular(borderRadius)
          ),
          child: child
        ),
      ),
    );
  }
}