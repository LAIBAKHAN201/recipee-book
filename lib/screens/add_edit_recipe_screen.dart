import 'package:flutter/material.dart';

class AddEditRecipeScreen extends StatelessWidget {
  const AddEditRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Add / Edit Recipe Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
