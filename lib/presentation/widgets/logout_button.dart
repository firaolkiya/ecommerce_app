import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Color.fromARGB(255, 255, 232, 178),
          child:Icon(Icons.logout,
          color: Colors.black,
          size: 18,
        )),
        SizedBox(width: 4),
        Text(
          'Log out',
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800
          ),
        ),
      ],
    );
  }
}