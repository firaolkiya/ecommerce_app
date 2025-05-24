import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class BlackButtton extends StatelessWidget {
  const BlackButtton({super.key, required this.onClick, required this.text,this.isLoading=false});
  final bool isLoading;
 final VoidCallback onClick;
 final String text;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      
      style: OutlinedButton.styleFrom(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ), 
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        minimumSize: const Size(double.infinity, 50),
        shadowColor: isLoading?Colors.grey:Colors.black87
      ),
      onPressed: isLoading?(){}:onClick, 
      child: isLoading?const CircularProgressIndicator():
       Text(text,style: GoogleFonts.urbanist(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white
        ),));
  }
}