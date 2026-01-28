import 'package:flutter/material.dart';

import 'about.dart';
import 'contact.dart';
import 'experince.dart';
import 'footer.dart';
import 'hero_section.dart';
import 'project.dart';
import 'skill.dart';

void main() {
  runApp(const PortfolioApp());
}

/// ---------------- APP ----------------
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Developer Portfolio',
      theme: ThemeData(useMaterial3: true),
      home: const PortfolioPage(),
    );
  }
}

/// ---------------- SECTION CONTAINER ----------------
class SectionContainer extends StatelessWidget {
  final Widget child;
  final Color background;
  final bool showTopDivider;
  final bool showBottomDivider;

  const SectionContainer({
    super.key,
    required this.child,
    required this.background,
    this.showTopDivider = false,
    this.showBottomDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width < 600 ? 20.0 : 80.0;

    return Container(
      width: double.infinity,
      color: background,
      child: Column(
        children: [
          if (showTopDivider) const SectionWaveDivider(flip: true),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: width < 900 ? 60 : 100,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: child,
            ),
          ),
          if (showBottomDivider) const SectionWaveDivider(),
        ],
      ),
    );
  }
}

/// ---------------- WAVE DIVIDER ----------------
class SectionWaveDivider extends StatelessWidget {
  final bool flip;
  const SectionWaveDivider({super.key, this.flip = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Transform(
        alignment: Alignment.center,
        transform: flip ? Matrix4.rotationX(3.1416) : Matrix4.identity(),
        child: CustomPaint(painter: _WavePainter()),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..lineTo(0, size.height * .6)
      ..quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height * .6,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// ---------------- PAGE ----------------
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  bool menuOpen = false;

  // Section keys
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final portfolioKey = GlobalKey();
  final contactKey = GlobalKey();

  String activeSection = "Home";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    void detect(GlobalKey key, String name) {
      final ctx = key.currentContext;
      if (ctx == null) return;
      final box = ctx.findRenderObject() as RenderBox;
      final pos = box.localToGlobal(Offset.zero).dy;

      if (pos < 120 && pos > -box.size.height + 120) {
        if (activeSection != name) {
          setState(() => activeSection = name);
        }
      }
    }

    detect(homeKey, "Home");
    detect(aboutKey, "About");
    detect(skillsKey, "Skills");
    detect(portfolioKey, "Portfolio");
    detect(contactKey, "Contact");
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// ---------- STICKY NAVBAR ----------
          SliverAppBar(
            pinned: true,
            elevation: 4,
            backgroundColor: Colors.blueGrey[900],
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: NavBar(
              isMobile: isMobile,
              menuOpen: menuOpen,
              activeSection: activeSection,
              onMenuTap: () => setState(() => menuOpen = !menuOpen),
              onNavigate: scrollTo,
              homeKey: homeKey,
              aboutKey: aboutKey,
              skillsKey: skillsKey,
              portfolioKey: portfolioKey,
              contactKey: contactKey,
            ),
          ),

          /// ---------- CONTENT ----------
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SectionContainer(
                  key: homeKey,
                  background: Colors.black,
                  showBottomDivider: true,
                  child: const HeroSection(),
                ),
                SectionContainer(
                  key: aboutKey,
                  background: Colors.white,
                  showTopDivider: true,
                  child: const AboutSection(),
                ),
                SectionContainer(
                  key: skillsKey,
                  background: const Color(0xFFF5F7FA),
                  child: const SkillsSection(),
                ),
                SectionContainer(
                  key: experienceKey,
                  background: Colors.white,
                  child: const ExperienceSection(),
                ),
                SectionContainer(
                  key: portfolioKey,
                  background: const Color(0xFFF5F7FA),
                  child: const ProjectsSection(),
                ),
                SectionContainer(
                  key: contactKey,
                  background: Colors.black38,
                  child: const ContactSection(),
                ),
                const SectionContainer(
                  background: Colors.black,
                  child: ProfessionalFooter(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- NAVBAR ----------------
class NavBar extends StatelessWidget {
  final bool isMobile;
  final bool menuOpen;
  final String activeSection;
  final VoidCallback onMenuTap;
  final Function(GlobalKey) onNavigate;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey portfolioKey;
  final GlobalKey contactKey;

  const NavBar({
    super.key,
    required this.isMobile,
    required this.menuOpen,
    required this.activeSection,
    required this.onMenuTap,
    required this.onNavigate,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.portfolioKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Er. Jeetendra Soni",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!isMobile)
                Row(
                  children: [
                    navItem("Home", homeKey),
                    navItem("About", aboutKey),
                    navItem("Skills", skillsKey),
                    navItem("Portfolio", portfolioKey),
                    navItem("Contact", contactKey),
                  ],
                )
              else
                IconButton(
                  icon: Icon(menuOpen ? Icons.close : Icons.menu, color: Colors.white),
                  onPressed: onMenuTap,
                ),
            ],
          ),
          if (isMobile && menuOpen)
            Column(
              children: [
                navItem("Home", homeKey),
                navItem("About", aboutKey),
                navItem("Skills", skillsKey),
                navItem("Portfolio", portfolioKey),
                navItem("Contact", contactKey),
              ],
            )
        ],
      ),
    );
  }

  Widget navItem(String title, GlobalKey key) {
    final isActive = activeSection == title;

    return TextButton(
      onPressed: () {
        onNavigate(key);
        if (isMobile) onMenuTap();
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.orangeAccent : Colors.white70,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(top: 4),
            height: 2,
            width: isActive ? 20 : 0,
            color: Colors.orangeAccent,
          )
        ],
      ),
    );
  }
}
