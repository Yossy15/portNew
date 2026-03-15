import 'package:flutter/material.dart';

import '../../../../widgets/social_button.dart';

class HomeSocialSection extends StatelessWidget {
  const HomeSocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: <Widget>[
        SocialButton(
          icon: Icons.code,
          label: 'GitHub',
          onTap: () {
            // TODO: open GitHub url
          },
        ),
        SocialButton(
          icon: Icons.business,
          label: 'LinkedIn',
          onTap: () {
            // TODO: open LinkedIn url
          },
        ),
        SocialButton(
          icon: Icons.mail,
          label: 'Email',
          onTap: () {
            // TODO: open email
          },
        ),
      ],
    );
  }
}

