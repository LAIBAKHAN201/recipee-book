import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = true;
  bool compactCards = false;
  bool cookingNotifications = true;
  bool autoSync = false;
  String defaultCategory = 'Lunch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E1C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Appearance"),
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: "Dark Theme",
            subtitle: "Currently using dark mode",
            value: isDarkTheme,
            onChanged: (val) {
              setState(() => isDarkTheme = val);
            },
          ),
          _buildSwitchTile(
            icon: Icons.grid_view_rounded,
            title: "Compact Cards",
            subtitle: "Use smaller cards to show more content",
            value: compactCards,
            onChanged: (val) {
              setState(() => compactCards = val);
            },
          ),
          _buildCardPreview(),

          const SizedBox(height: 24),
          _buildSectionTitle("Preferences"),
          _buildNavigationTile(
            icon: Icons.category,
            title: "Default Category",
            subtitle: "New recipes will default to $defaultCategory",
            trailingText: defaultCategory,
            onTap: () {
              // Navigation placeholder
            },
          ),
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: "Cooking Notifications",
            subtitle: "Get reminders for cooking times",
            value: cookingNotifications,
            onChanged: (val) {
              setState(() => cookingNotifications = val);
            },
          ),
          _buildSwitchTile(
            icon: Icons.sync,
            title: "Auto Sync",
            subtitle: "Automatically sync recipes across devices",
            value: autoSync,
            onChanged: (val) {
              setState(() => autoSync = val);
            },
          ),

          const SizedBox(height: 24),
          _buildSectionTitle("Data"),
          _buildSimpleTile(
            icon: Icons.file_upload_outlined,
            title: "Export Recipes",
            subtitle: "Save your recipes as a backup file",
            onTap: () {},
          ),
          _buildSimpleTile(
            icon: Icons.delete_outline,
            title: "Clear Cache",
            subtitle: "Free up storage space",
            onTap: () {},
          ),

          const SizedBox(height: 24),
          _buildSectionTitle("About"),
          _buildSimpleTile(
            icon: Icons.menu_book,
            title: "CookBook",
            subtitle: "Version 1.0.0\nYour personal recipe collection and cooking companion",
          ),
          _buildSimpleTile(
            icon: Icons.help_outline,
            title: "Help & Support",
            subtitle: "Get help with using the app",
            onTap: () {},
          ),
          _buildSimpleTile(
            icon: Icons.star_border,
            title: "Rate App",
            subtitle: "Rate us on the App Store",
            onTap: () {},
          ),
          _buildSimpleTile(
            icon: Icons.policy_outlined,
            title: "Privacy Policy",
            subtitle: "Review our privacy practices",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return SwitchListTile(
      activeColor: const Color(0xFFB18CFF),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      value: value,
      onChanged: onChanged,
      title: Row(
        children: [
          Icon(icon, color: const Color(0xFFB18CFF)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 36),
        child: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildNavigationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailingText,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFFB18CFF)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: Text(
        trailingText,
        style: const TextStyle(color: Color(0xFFB18CFF), fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSimpleTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: const Color(0xFFB18CFF)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: Colors.grey))
          : null,
    );
  }

  Widget _buildCardPreview() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF1C1C2E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Sample Recipe", style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 4),
          Text("30 minutes • Rating: 4.5 stars", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
