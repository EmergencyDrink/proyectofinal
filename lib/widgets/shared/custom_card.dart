import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final VoidCallback? onTap;
  final double borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.onTap,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: child,
      ),
    );
  }
}