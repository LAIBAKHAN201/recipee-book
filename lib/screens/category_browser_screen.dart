import 'package:flutter/material.dart';

class CategoryBrowserScreen extends StatelessWidget {
  const CategoryBrowserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Browse Recipes by Categories",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
