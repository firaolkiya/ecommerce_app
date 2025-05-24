import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(),
      
       decoration: InputDecoration( 
        contentPadding: EdgeInsets.all(20),
        filled: true,
        hintText: hint,
        hintStyle: GoogleFonts.urbanist(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.w500
        ),
        fillColor: Color.fromARGB(255, 247, 248, 249),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 11, 98, 228),
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 232, 236, 244),
          )
        )
       ),
    );
  }
}