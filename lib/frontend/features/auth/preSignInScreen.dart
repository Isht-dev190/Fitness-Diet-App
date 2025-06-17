import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class PreSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF6F61),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Transform.translate(
                offset: Offset(0, -20), 
                child: SvgPicture.asset(
                  'assets/helper svgs/prelogin_yoga.svg',
                  width: 311,
                  height: 290,
                ),
              ),
                                          

              // Welcome Back Text
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'WELCOME',
                 style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Sign In Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    print('Sign In button pressed');
                    context.push('/sign-in');
                    // Add sign in logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(250, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'SIGN IN',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFFF6F61),
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              // New Here Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    print('New Here button pressed');
                    context.push('/register-age');
                  // Add new user registration logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6F61),
                    minimumSize: Size(250, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: Text(
                    'NEW HERE',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}