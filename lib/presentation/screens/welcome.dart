import 'package:ecommerce/core/utils/devices.dart';
import 'package:ecommerce/presentation/screens/login.dart';
import 'package:ecommerce/presentation/widgets/black_buttton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/img.png')),
      
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppDevices.getDeviceWidth(context)*0.1),
          child: Column(
            children: [
              Flexible(child: SizedBox(height: AppDevices.getDeviceHeight(context)*0.6,)),
              SvgPicture.asset('assets/images/Logo.svg'),
              const SizedBox(height: 12,),
              Text(
                "Fake Store",
                style: GoogleFonts.urbanist(
                  color: const Color.fromARGB(255, 37, 37, 37),
                  fontSize: 28,
                  fontWeight: FontWeight.w600
                ),
          
              ),
              const SizedBox(height: 15,),
          
              BlackButtton(
                text: 'Login',
                onClick: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage(),)
              );
             },)
            ],
          ),
        ),
        ),
    );
  }
}