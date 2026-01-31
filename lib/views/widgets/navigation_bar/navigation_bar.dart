import 'package:flutter/material.dart';
import 'package:mywebsite/utils/url_launcher.dart';
import 'package:mywebsite/views/widgets/dialogs/contact_form.dart';
import 'package:mywebsite/views/widgets/navigation_bar/navbar_item.dart';
import 'package:mywebsite/views/widgets/navigation_bar/navbar_logo.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) {
        return const NavigationBarMobile();
      },
      tablet: (context) {
        return const NavigationBarTabletDesktop();
      },
      desktop: (context) {
        return const NavigationBarTabletDesktop();
      },
    );
  }
}

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const NavBarLogo(),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Er. Jeetendra Soni",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(width: 10),
                NavbarItem(
                  item: "Home",
                  onTap: () {
                    debugPrint("Home tapped");
                  },
                ),

                /// ---- CONTACT BUTTON ----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showAdaptiveDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const ContactFormDialog();
                          });
                    },
                    icon: const Icon(Icons.mail_outline),
                    label: const Text("Contact Me"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class NavigationBarMobile extends StatelessWidget {
  const NavigationBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const NavBarLogo(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Er. Jeetendra Soni",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(width: 10),

                /// ---- CONTACT BUTTON ----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    onPressed: () {
                      openPhoneDialer(context: context, phoneNumber: "+917509005537");
                    },
                    icon: const Icon(Icons.call),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    onPressed: () {
                      showAdaptiveDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const ContactFormDialog();
                          });
                    },
                    icon: const Icon(Icons.mail_outline),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
