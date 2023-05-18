import 'package:flutter/material.dart';

class HomeIntroduction extends StatelessWidget {
  const HomeIntroduction(
      {super.key,
      required this.title,
      required this.description,
      required this.icon});
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 200, color: Colors.white),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(description,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
