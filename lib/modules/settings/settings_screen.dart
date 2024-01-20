import 'package:flutter/material.dart';
import 'package:souqy/modules/profile/edit_profile_screen.dart';
import 'package:souqy/shared/components/components.dart';
import 'package:souqy/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        buildSettingItem(
          icon: Icons.edit,
          text: 'Edit Profile',
          function: () {
            navigateTo(context, EditProfileScreen());
          },
        ),
        buildSettingItem(
          icon: Icons.lock,
          text: 'Change Password',
          function: () {},
        ),
        buildSettingItem(
          icon: Icons.language,
          text: 'Change Language',
          function: () {},
        ),
        buildSettingItem(
          icon: Icons.info_outline,
          text: 'About App',
          function: () {
            showAboutDialog(
              context: context,
              applicationName: 'Souqy',
              applicationVersion: '1.0.0',
              applicationIcon: Image.asset(
                'assets/onboarding/onboarding_00.png',
                width: 50.0,
                height: 50.0,
              ),
              applicationLegalese: '© 2024 Andrew Aziz',
              children: [
                const Text(
                  'Souqy is a mobile application that allows you to shop and buy products online.',
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
        buildSettingItem(
          icon: Icons.logout,
          text: 'Logout',
          function: () {
            signOut(context);
          },
        ),
      ],
    );
  }



}
