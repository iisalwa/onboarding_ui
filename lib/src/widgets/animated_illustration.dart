import 'package:flutter/material.dart';

class AnimatedIllustration extends StatefulWidget {
  const AnimatedIllustration({super.key, required this.icon});

  final IconData icon;

  @override
  State<AnimatedIllustration> createState() => _AnimatedIllustrationState();
}

class _AnimatedIllustrationState extends State<AnimatedIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _elevation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _elevation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Transform.scale(
        scale: _scale.value,
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: _elevation.value,
          shadowColor: scheme.primary.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 180,
            height: 180,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [
                  scheme.primary.withValues(alpha: 0.12),
                  scheme.primary.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(widget.icon, size: 88, color: scheme.primary),
          ),
        ),
      ),
    );
  }
}
