import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({super.key, 
  required this.controller, 
  required this.hint, required this.showText, required this.onShowPassword
  });
  final TextEditingController controller;
  final String hint;
  final bool showText;
  final VoidCallback onShowPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: TextEditingController(),
      obscureText: !showText,
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 232, 236, 244),
          )
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 11, 98, 228),
          )
        ),
        suffixIcon: IconButton(
          onPressed: onShowPassword,
           icon: Icon(Icons.remove_red_eye)
        )
       ),
    );
  }
}