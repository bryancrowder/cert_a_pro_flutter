import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;
  const CustomTextField({super.key, required this.controller, required this.iconData, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              contentPadding: const  EdgeInsets.all(0),
              border: InputBorder.none,
              prefixIcon: Icon(iconData),
              hintStyle: const TextStyle(),
              hintText: hintText),
        ),
      ),
    );
  }
}
