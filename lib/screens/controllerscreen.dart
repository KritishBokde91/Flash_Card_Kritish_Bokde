import 'package:flashcard/screens/addquestionscreen.dart';
import 'package:flashcard/screens/homescreen.dart';
import 'package:flashcard/screens/profilescreen.dart';
import 'package:flutter/material.dart';

class Controllerscreen extends StatefulWidget {
  const Controllerscreen({super.key});

  @override
  State<Controllerscreen> createState() => _ControllerscreenState();
}

class _ControllerscreenState extends State<Controllerscreen> {
  int currentIndex = 0;
  final List<Widget> _screens = [
    const Homescreen(),
    const Addquestionscreen(),
    const Profilescreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashCard'),
        centerTitle: true,
      ),
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Colors.blue[900],
        currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
            ),
          ]
      ),
    );
  }
}
