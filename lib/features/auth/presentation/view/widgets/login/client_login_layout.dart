import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/Repo/firebase_service_login_client.dart';
import '../../../../../profile/presentation/view/pages/profile/client_profile_page.dart';
import '../../../view_model/cubit/login/client_login_cubit.dart';
import '../../../view_model/cubit/login/client_login_state.dart';
import '../Custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../pages/register/register_screen.dart';

class ClientLoginLayout extends StatelessWidget {
  const ClientLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientLoginCubit(FirebaseServiceLoginClient()),
      child: BlocConsumer<ClientLoginCubit, ClientLoginState>(
        listener: (context, state) {
          if (state is ClientLoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is ClientLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ClientProfilePage()),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ClientLoginCubit>();
          final size = MediaQuery.of(context).size;

          Map<String, String?> errors = {};
          if (state is ClientLoginValidation) errors = state.errors;
          final isLoading = state is ClientLoginLoading;

          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.03),
                      CustomTextFieldLogin(
                        hinText: "Email",
                        controller: cubit.emailController,
                      ),
                      if (errors['email'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            errors['email']!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: size.height * 0.03),
                      CustomTextFieldLogin(
                        hinText: "Password",
                        controller: cubit.passwordController,
                        obscureText: true,
                      ),
                      if (errors['password'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            errors['password']!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      CustomButton(
                        text: "Login",
                        onTap: () => cubit.login(context),
                      ),
                      SizedBox(height: size.height * 0.05),
                      CustomButtonSocial(
                        textSocial: "Continue with Google",
                        icon: Icons.g_mobiledata,
                      ),
                      CustomTextRegister(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                        text: "Don't have an account? ",
                        textColor: "Register",
                      ),
                    ],
                  ),
                ),
                if (isLoading)
                  Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
