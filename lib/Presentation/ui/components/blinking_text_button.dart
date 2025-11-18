import 'package:flutter/material.dart';

class BlinkingTextButton extends StatefulWidget {
  const BlinkingTextButton({
    super.key,
    required this.onPressed,
    required this.child,
  });
  final VoidCallback onPressed;
  final Widget child;

  @override
  State<BlinkingTextButton> createState() => _BlinkingTextButtonState();
}

class _BlinkingTextButtonState extends State<BlinkingTextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _colorAnimation = ColorTween(
      begin: Colors.deepPurple,
      end: Colors.green,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  void _handlePressed() {
    _controller.forward(from: 0.0);
    widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) => TextButton(
        onPressed: _handlePressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(_colorAnimation.value),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
        ),
        child: widget.child,
      ),
    );
  }
}
