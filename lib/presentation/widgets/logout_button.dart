import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: (){
        context.read<AuthBloc>().add(LogoutEvent());
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color.fromARGB(255, 255, 232, 178),
            child:Icon(Icons.logout,
            color: Colors.black,
            size: 18,
          )),
          const SizedBox(width: 4),
          Text(
            'Log out',
            style: GoogleFonts.lato(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800
            ),
          ),
        ],
      ),
    );
  }
}