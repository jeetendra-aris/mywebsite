import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < 500;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40 : 80,
          ),
          child: isMobile ? const _HeroMobile() : const _HeroDesktop(),
        );
      },
    );
  }
}

class _HeroMobile extends StatelessWidget {
  const _HeroMobile();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroText(isMobile: true),
        SizedBox(height: 40),
        Center(child: _HeroGraphic(isMobile: true)),
      ],
    );
  }
}

class _HeroDesktop extends StatelessWidget {
  const _HeroDesktop();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _HeroText(isMobile: false),
        ),
        SizedBox(width: 40),
        _HeroGraphic(isMobile: false),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool isMobile;
  const _HeroText({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
          ),
          child: const Text(
            'Senior Flutter Developer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Building Scalable\nMobile & Web Apps',
          style: TextStyle(
            fontSize: isMobile ? 32 : 48,
            height: 1.2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Flutter expert focused on performance, clean architecture, '
          'and beautiful user experiences.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _PrimaryCTA(),
            _SecondaryCTA(),
          ],
        ),
      ],
    );
  }
}

class _PrimaryCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        onPressed: () {
          // Scroll to contact section
        },
        child: const Text(
          'Hire Me',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _SecondaryCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          side: const BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          // Download CV
        },
        child: const Text(
          'Download CV',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _HeroGraphic extends StatelessWidget {
  final bool isMobile;
  const _HeroGraphic({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background gradient circle
          Container(
            width: isMobile ? 220 : 300,
            height: isMobile ? 220 : 300,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
            ),
          ),

          // Flutter icon
          const Icon(
            Icons.flutter_dash,
            size: 120,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
