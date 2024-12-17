import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';


class ResponsiveSettings extends StatefulWidget {
  final String studentId;

  const ResponsiveSettings({super.key, required this.studentId});

  @override
  _ResponsiveSettingsState createState() => _ResponsiveSettingsState();
}

class _ResponsiveSettingsState extends State<ResponsiveSettings> {
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
                            child: Icon(Icons.person, size: 20, color: Colors.white),
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
                  const SizedBox(height: 240),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Sign out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  if (selectedMainOption != null && isLargeScreen)
                    Expanded(child: _buildSubSettings()),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavContainer(
        selectedIndex: 3,
        studentId: widget.studentId,
      ),
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
      tileColor: isSelected ? Colors.blue.withOpacity(0.1) : null,
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