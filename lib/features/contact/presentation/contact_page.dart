import 'package:flutter/material.dart';

import '../../../widgets/section_container.dart';
import '../../../widgets/social_button.dart';
import '../../../widgets/app_navbar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: const AppNavBar(title: 'Contact'),
        //   body:
        SectionContainer(
      title: 'Let\'s work together',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Have a project in mind or just want to say hi? Reach out via any of the channels below.',
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              SocialButton(
                icon: Icons.mail_outline,
                label: 'your@email.com',
                onTap: () {
                  // TODO: mailto
                },
              ),
              SocialButton(
                icon: Icons.business,
                label: 'LinkedIn',
                onTap: () {
                  // TODO: linkedin
                },
              ),
              SocialButton(
                icon: Icons.code,
                label: 'GitHub',
                onTap: () {
                  // TODO: github
                },
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
