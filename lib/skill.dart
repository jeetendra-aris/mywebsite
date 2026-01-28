import 'package:flutter/material.dart';
import 'package:mywebsite/utils.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width < 700
        ? 2
        : width < 1000
            ? 3
            : 6;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Skills'),
        const SizedBox(height: 40),
        GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          childAspectRatio: 1.2,
          children: const [
            SkillCard(
              title: 'Flutter',
              icon: Icons.flutter_dash,
              color: Color(0xFF02569B),
            ),
            SkillCard(
              title: 'Dart',
              icon: Icons.code,
              color: Color(0xFF0175C2),
            ),
            SkillCard(
              title: 'Firebase',
              icon: Icons.local_fire_department,
              color: Color(0xFFFFCA28),
            ),
            SkillCard(
              title: 'REST APIs',
              icon: Icons.api,
              color: Color(0xFF4CAF50),
            ),
            SkillCard(
              title: 'Flutter Web',
              icon: Icons.web,
              color: Color(0xFF673AB7),
            ),
            SkillCard(
              title: 'State Management',
              icon: Icons.layers,
              color: Color(0xFF009688),
            ),
            SkillCard(
              title: 'Clean Architecture',
              icon: Icons.architecture,
              color: Color(0xFF3F51B5),
            ),
            SkillCard(
              title: 'Performance',
              icon: Icons.speed,
              color: Color(0xFFE91E63),
            ),
          ],
        ),
      ],
    );
  }
}

class SkillCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;

  const SkillCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    // final isMobile = context.size!.width < 500;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: _hovered ? (Matrix4.identity()..translate(0, -8)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(.25),
              blurRadius: _hovered ? 30 : 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(.1),
              ),
              child: Icon(
                widget.icon,
                size: 36,
                color: widget.color,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
