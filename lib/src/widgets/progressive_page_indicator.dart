import 'package:flutter/material.dart';

class ProgressivePageIndicator extends StatelessWidget {
  const ProgressivePageIndicator({
    super.key,
    required this.length,
    required this.controller,
  });

  final int length;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 20,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final page = controller.hasClients
              ? controller.page ?? controller.initialPage.toDouble()
              : 0.0;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(length, (i) {
              final selectedness = (1.0 - (page - i).abs()).clamp(0.0, 1.0);
              final width = 10 + (20 * selectedness);
              final opacity = 0.35 + (0.65 * selectedness);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: width,
                height: 8,
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(99),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
