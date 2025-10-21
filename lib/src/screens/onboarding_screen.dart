import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';
import '../widgets/animated_illustration.dart';
import '../widgets/primary_button.dart';
import '../widgets/progressive_page_indicator.dart';
import '../router/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final pages = <OnboardingPageModel>[
    const OnboardingPageModel(
      title: 'Find your flow',
      subtitle: 'Plan focus sessions, reduce friction, and stay in the zone.',
      icon: Icons.bubble_chart_rounded,
    ),
    const OnboardingPageModel(
      title: 'Track & reflect',
      subtitle: 'Build habits with gentle nudges and mindful journaling.',
      icon: Icons.fact_check_rounded,
    ),
    const OnboardingPageModel(
      title: 'Visualize progress',
      subtitle: 'Beautiful charts to see your improvement over time.',
      icon: Icons.auto_graph_rounded,
    ),
  ];

  final _controller = PageController();
  final _current = ValueNotifier<int>(0);

  @override
  void dispose() {
    _controller.dispose();
    _current.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final page = _controller.page?.round() ?? 0;
      if (_current.value != page) _current.value = page;
    });
  }

  /// Save onboarding completion and navigate to Home
  Future<void> _finish() async {
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRouter.home, (route) => false);
  }

  void _next() {
    final isLast = _current.value == pages.length - 1;
    if (isLast) {
      _finish();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _skip() => _finish();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: [TextButton(onPressed: _skip, child: const Text('Skip'))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  final p = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        _AnimatedHeader(title: p.title, subtitle: p.subtitle),
                        const SizedBox(height: 24),
                        const Spacer(),
                        AnimatedIllustration(icon: p.icon),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  ProgressivePageIndicator(
                    length: pages.length,
                    controller: _controller,
                  ),
                  const Spacer(),
                  ValueListenableBuilder<int>(
                    valueListenable: _current,
                    builder: (_, idx, __) {
                      final isLast = idx == pages.length - 1;
                      return PrimaryButton(
                        label: isLast ? 'Get Started' : 'Next',
                        icon: isLast
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                        onPressed: _next,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedHeader extends StatefulWidget {
  const _AnimatedHeader({required this.title, required this.subtitle});

  final String subtitle;
  final String title;

  @override
  State<_AnimatedHeader> createState() => _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<_AnimatedHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _c,
    curve: Curves.easeOut,
  );

  late final Animation<Offset> _slide = Tween(
    begin: const Offset(0, 0.15),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_c);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _c.forward(from: 0);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Column(
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: text.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: text.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
