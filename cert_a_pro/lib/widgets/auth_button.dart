import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function()? onTap;
  const AuthButton({super.key, required this.iconData, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(iconData), 
                    ),
                    Align(
                    alignment: Alignment.center,
                    child:  Text(title), 
                    ),
               ]),
        ),
      ),
    );
  }
}
