import 'package:flutter/material.dart';

class BrutalistStyledButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const BrutalistStyledButton({super.key, required this.text, required this.onTap});

  @override
  State<BrutalistStyledButton> createState() => _BrutalistStyledButtonState();
}

class _BrutalistStyledButtonState extends State<BrutalistStyledButton> {
  final Duration duration = const Duration(milliseconds: 50);

  final int shadowLength = 4;

  bool showShadow = true;

  void onHideShadow(dynamic) {
    showShadow = false;
    setState(() {});
  }

  void onShowShadow(dynamic) {
    showShadow = true;
    setState(() {});
  }

  List<BoxShadow> generateShadows() {
    List<BoxShadow> shadows = [];

    if (!showShadow) return shadows;

    for (int i = 0; i < shadowLength; i++) {
      final double shadowOffset = i + 1;

      final BoxShadow shadow = BoxShadow(
        color: Colors.black,
        spreadRadius: 0,
        blurRadius: 0,
        offset: Offset(shadowOffset, shadowOffset),
      );

      shadows.add(shadow);
    }

    return shadows;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: onHideShadow,
      onVerticalDragEnd: onShowShadow,
      onHorizontalDragEnd: onShowShadow,
      onTapUp: (_) async {
        //You can customize the waiting duration to suit your needs
        await Future.delayed(const Duration(milliseconds: 150));
        onShowShadow(null);
      },
      child: AnimatedContainer(
        duration: duration,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          boxShadow: generateShadows(),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
