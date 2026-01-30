import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

/// ---------------- PAGE ----------------
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  /// Section Keys
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final portfolioKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;

    final box = ctx.findRenderObject() as RenderBox;
    final viewport = RenderAbstractViewport.of(box);
    final offset = viewport.getOffsetToReveal(box, 0).offset;

    _scrollController.animateTo(
      offset - 90,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          /// ---------- CLEAN STICKY NAVBAR ----------
          SliverAppBar(
            pinned: true,
            elevation: 3,
            backgroundColor: Colors.blueGrey[900],
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            title: SimpleNavBar(
              onContactTap: () {
                showAdaptiveDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const ContactFormDialog();
                    });
              },
            ),
          ),

          /// ---------- CONTENT ----------
          SliverToBoxAdapter(
            child: Column(
              children: [
                SectionContainer(
                  key: homeKey,
                  background: Colors.black,
                  showBottomDivider: true,
                  child: const HeroSection(),
                ),
                SectionContainer(
                  key: aboutKey,
                  background: Colors.white,
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
                  background: Colors.blueGrey.shade900,
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

/// ---------------- SIMPLE NAVBAR ----------------
class SimpleNavBar extends StatelessWidget {
  final VoidCallback onContactTap;

  const SimpleNavBar({
    super.key,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// ---- NAME ----
          const Flexible(
            child: Text(
              "Er. Jeetendra Soni",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /// ---- CONTACT BUTTON ----
          ElevatedButton.icon(
            onPressed: onContactTap,
            icon: const Icon(Icons.mail_outline),
            label: Text(isMobile ? "Contact" : "Contact Me"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 22,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
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
              vertical: 60,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: child,
            ),
          ),
          if (showBottomDivider)
            const SectionWaveDivider(
              flip: true,
            ),
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

class ContactFormDialog extends StatefulWidget {
  const ContactFormDialog({super.key});

  @override
  State<ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<ContactFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final mobCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final messageCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width < 600 ? width : 450,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// -------- HEADER --------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Contact Me",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                /// -------- NAME --------
                _inputField(
                  controller: nameCtrl,
                  label: "Your Name",
                  icon: Icons.person_outline,
                  validator: (v) => v!.isEmpty ? "Please enter your name" : null,
                ),
                const SizedBox(height: 14),

                /// -------- NAME --------
                _inputField(
                  controller: mobCtrl,
                  label: "Mobile no.",
                  icon: Icons.phone_android,
                  validator: (v) => v!.isEmpty ? "Please enter your mobile no." : null,
                ),

                const SizedBox(height: 14),

                /// -------- EMAIL --------
                _inputField(
                  controller: emailCtrl,
                  label: "Email Address",
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v!.isEmpty) return "Email is required";
                    if (!v.contains("@")) return "Enter valid email";
                    return null;
                  },
                ),

                const SizedBox(height: 14),

                /// -------- MESSAGE --------
                _inputField(
                  controller: messageCtrl,
                  label: "Message",
                  icon: Icons.message_outlined,
                  maxLines: 4,
                  validator: (v) => v!.isEmpty ? "Please write a message" : null,
                ),

                const SizedBox(height: 24),

                /// -------- BUTTONS --------
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: API / Email / Firebase submission
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Message sent successfully 🚀"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Send Message",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// -------- INPUT FIELD WIDGET --------
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
