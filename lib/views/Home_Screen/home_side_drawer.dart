import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qrfinal_personalized/res/routes/routes_names.dart';

class HomeSideDrawer extends StatelessWidget {
   HomeSideDrawer({super.key});
  final storage = GetStorage();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  "Muhammad Ahmad",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Student - BS(SE) 8th Semester",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // 🔹 PROFILE & INFO
          _buildSectionTitle("Profile"),
          _buildDrawerItem(Icons.person_outline, "My Profile", () {
            // Get.toNamed(RouteName.profileScreen);
          }),
          _buildDrawerItem(Icons.badge_outlined, "Student ID Card", () {
            // Get.toNamed(RouteName.studentIdScreen);
          }),

          // 🔹 SUPPORT & INFO
          _buildSectionTitle("Information"),
          _buildDrawerItem(Icons.info_outline, "About App", () {
            // Get.toNamed(RouteName.aboutApp);
          }),
          _buildDrawerItem(Icons.help_outline, "Help & Support", () {
            // Get.toNamed(RouteName.helpScreen);
          }),
          _buildDrawerItem(Icons.privacy_tip_outlined, "Privacy Policy", () {
            // Add link or route
          }),
          _buildDrawerItem(Icons.feedback_outlined, "Feedback", () {
            // Get.toNamed(RouteName.feedbackScreen);
          }),

          // 🔹 SETTINGS
          _buildSectionTitle("Settings"),
          _buildDrawerItem(Icons.settings, "App Settings", () {
            // Get.toNamed(RouteName.settingsScreen);
          }),
          _buildDrawerItem(Icons.language, "Change Language", () {
            // Add language selection
          }),
          _buildDrawerItem(Icons.dark_mode_outlined, "Dark Mode", () {
            // Add theme toggle
          }),

          const Divider(),

          // 🔹 LOGOUT
          _buildDrawerItem(Icons.logout, "Logout", () {
            storage.write('isLoggedIn', false);
            Get.offAllNamed(RouteName.loginScreen);
          }, color: Colors.red),
        ],
      ),
    );
  }

  // Drawer item widget
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap,
      {Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontSize: 15),
      ),
      onTap: onTap,
    );
  }

  // Section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
