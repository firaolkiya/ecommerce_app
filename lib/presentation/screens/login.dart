import 'package:ecommerce/presentation/bloc/auth/auth_bloc.dart';
import 'package:ecommerce/presentation/screens/dashboard.dart';
import 'package:ecommerce/presentation/widgets/black_buttton.dart';
import 'package:ecommerce/presentation/widgets/password_field.dart';
import 'package:ecommerce/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool showText = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 41,
            width: 41,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color.fromARGB(255, 232, 236, 242),
              ),
            ),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isLoggedIn) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          }

          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Welcome back! Glad to see you, Again!',
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: emailController,
                  hint: 'Enter your username',
                ),
                const SizedBox(height: 15),
                CustomPasswordField(
                  showText: showText,
                  onShowPassword: () {
                    setState(() {
                      showText = !showText;
                    });
                  },
                  controller: passwordController,
                  hint: 'Enter your password',
                ),
                const SizedBox(height: 30),
                 BlackButtton(
                        isLoading: state.isLoading,
                        text: 'Login',
                        onClick: () {
                          final username = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (username.isNotEmpty && password.isNotEmpty) {
                            context.read<AuthBloc>().add(
                                  LoginEvent(
                                    username: username,
                                    password: password,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill all fields'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
