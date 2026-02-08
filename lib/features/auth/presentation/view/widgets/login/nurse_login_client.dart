import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/Repo/firebase_service-login_nurse.dart';
import '../../../view_model/cubit/login/nurse_login_cubit.dart';
import '../../pages/profile/profile_nurse.dart';
import '../Custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';
import '../../pages/register/register_screen.dart';
import '../../../../../../core/widgets/custom_button.dart';

class NurseLoginLayout extends StatelessWidget {
  NurseLoginLayout({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => NurseLoginCubit(NurseAuthRepository()),
      child: BlocConsumer<NurseLoginCubit, NurseLoginState>(
        listener: (context, state) {
          if (state is NurseLoginError) {
            showSnack(context, state.message);
          } else if (state is NurseLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NurseProfilePage()),
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is NurseLoginLoading;

          return Column(
            children: [
              SizedBox(height: size.height * 0.03),

              CustomTextFieldLogin(
                hinText: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),

              SizedBox(height: size.height * 0.03),

              CustomTextFieldLogin(
                hinText: "Password",
                controller: passwordController,
                obscureText: true,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),

              isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                text: "Login",
                onTap: () {
                  context.read<NurseLoginCubit>().login(
                    emailController.text,
                    passwordController.text,
                  );
                },
              ),

              SizedBox(height: size.height * 0.05),

              CustomButtonSocial(
                textSocial: "Continue with Google",
                icon: Icons.g_mobiledata,
              ),

              SizedBox(height: size.height * 0.01),

              CustomTextRegister(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                text: "Don't have an account? ",
                textColor: "Register",
              ),
            ],
          );
        },
      ),
    );
  }
}
