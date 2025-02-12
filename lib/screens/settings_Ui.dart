import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import 'sign_in.dart';

class ResponsiveSettings extends StatefulWidget {
  const ResponsiveSettings({super.key});

  @override
  ResponsiveSettingsState createState() => ResponsiveSettingsState();
}

class ResponsiveSettingsState extends State<ResponsiveSettings> {
  String? selectedMainOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          bool isExtraLargeScreen = constraints.maxWidth > 1200;

          double settingsPanelWidth = constraints.maxWidth;
          if (isLargeScreen) {
            settingsPanelWidth = constraints.maxWidth * 0.5;
          }
          if (isExtraLargeScreen) {
            settingsPanelWidth = constraints.maxWidth * 0.3;
          }

          return Center(
            child: Container(
              width: settingsPanelWidth,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person,
                                size: 20, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          if (isLargeScreen)
                            const Text(
                              'NEXT STEP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Explore',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsButton(
                    icon: Icons.settings,
                    title: 'General',
                    isSelected: selectedMainOption == 'General',
                  ),
                  _buildSettingsButton(
                    icon: Icons.language,
                    title: 'Language',
                    isSelected: selectedMainOption == 'Language',
                  ),
                  _buildSettingsButton(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    isSelected: selectedMainOption == 'Dark Mode',
                  ),
                  _buildSettingsButton(
                    icon: Icons.privacy_tip,
                    title: 'Privacy',
                    isSelected: selectedMainOption == 'Privacy',
                  ),
                  _buildSettingsButton(
                    icon: Icons.description,
                    title: 'Licenses',
                    isSelected: selectedMainOption == 'Licenses',
                  ),
                  const SizedBox(height: 140),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final authService = Get.find<AuthService>();
                            await authService.signOut();
                            Get.offAll(() => const ResponsiveSignIn());
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Failed to sign out',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Sign out',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  if (selectedMainOption != null && isLargeScreen)
                    Expanded(child: _buildSubSettings()),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavContainer(
          selectedIndex: 3), // Use the BottomNavContainer widget here
    );
  }

  Widget _buildSettingsButton({
    required IconData icon,
    required String title,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : null),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      tileColor: isSelected ? Colors.blue.withAlpha(25) : null,
      onTap: () {
        setState(() {
          selectedMainOption = title;
        });
        if (MediaQuery.of(context).size.width <= 600) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _SubSettingsScreen(title: title),
            ),
          );
        }
      },
    );
  }

  Widget _buildSubSettings() {
    if (selectedMainOption == 'General') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'General Settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildSubSettingTile(
            title: 'Notifications',
            subtitle: 'Configure notification settings',
            icon: Icons.notifications,
          ),
          _buildSubSettingTile(
            title: 'Sound',
            subtitle: 'Adjust sound settings',
            icon: Icons.volume_up,
          ),
          _buildSubSettingTile(
            title: 'Display',
            subtitle: 'Customize display options',
            icon: Icons.display_settings,
          ),
        ],
      );
    }
    return Center(
      child: Text('$selectedMainOption settings coming soon'),
    );
  }

  Widget _buildSubSettingTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _SubSettingsScreen extends StatelessWidget {
  final String title;

  const _SubSettingsScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _SubSettingsContent(title: title),
      ),
    );
  }
}

class _SubSettingsContent extends StatelessWidget {
  final String title;

  const _SubSettingsContent({required this.title});

  @override
  Widget build(BuildContext context) {
    if (title == 'General') {
      return Column(
        children: [
          _buildSubSettingTile(
            title: 'Notifications',
            subtitle: 'Configure notification settings',
            icon: Icons.notifications,
          ),
          _buildSubSettingTile(
            title: 'Sound',
            subtitle: 'Adjust sound settings',
            icon: Icons.volume_up,
          ),
          _buildSubSettingTile(
            title: 'Display',
            subtitle: 'Customize display options',
            icon: Icons.display_settings,
          ),
        ],
      );
    }
    return Center(
      child: Text('$title settings coming soon'),
    );
  }

  Widget _buildSubSettingTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedMainOption = 'General';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Desktop/Tablet layout
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                // Left side menu
                SizedBox(
                  width: 250,
                  child: _buildMainSettings(),
                ),
                // Vertical divider
                const VerticalDivider(width: 1),
                // Right side content
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildSubSettings(),
                  ),
                ),
              ],
            );
          }
          // Mobile layout
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildMainSettings(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildSubSettings(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () async {
            try {
              final authService = Get.find<AuthService>();
              await authService.signOut();
              Get.offAll(() => const ResponsiveSignIn());
            } catch (e) {
              Get.snackbar('Error', 'Failed to sign out');
            }
          },
          child: const Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildMainSettings() {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          selected: selectedMainOption == 'General',
          leading: const Icon(Icons.settings),
          title: const Text('General'),
          onTap: () => setState(() => selectedMainOption = 'General'),
        ),
        ListTile(
          selected: selectedMainOption == 'Privacy',
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy'),
          onTap: () => setState(() => selectedMainOption = 'Privacy'),
        ),
        // Add more main options...
      ],
    );
  }

  Widget _buildSubSettings() {
    if (selectedMainOption == 'General') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'General Settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildSubSettingTile(
            title: 'Notifications',
            subtitle: 'Configure notification settings',
            icon: Icons.notifications,
          ),
          _buildSubSettingTile(
            title: 'Sound',
            subtitle: 'Adjust sound settings',
            icon: Icons.volume_up,
          ),
        ],
      );
    }
    // Add other sub-settings...
    return const SizedBox.shrink();
  }

  Widget _buildSubSettingTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Handle sub-setting tap
      },
    );
  }
}
