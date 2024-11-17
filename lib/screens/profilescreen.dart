import 'package:flutter/material.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQAiSbUgqCbN_h3H7g5tjIZK4ljpN7cOAOFg&s'), // Replace with your image path
                ),
                const SizedBox(height: 16),
                const Text(
                  'Kritish Subhash Bokde',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                // List of options
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Account'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle account settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.brightness_2),
                  title: const Text('Dark Mode'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle dark mode toggle
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle email settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Security'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle security settings
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.new_releases),
                  title: const Text('What\'s New'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle what's new
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Terms of Service'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle terms of service
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle privacy policy
                  },
                ),

                const SizedBox(height: 24),

                // Logout button
                ElevatedButton(
                  onPressed: () {
                    // Handle logout action
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
