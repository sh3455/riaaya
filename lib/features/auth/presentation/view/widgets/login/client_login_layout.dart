import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riaaya_app/features/auth/presentation/view_model/cubit/login/client_login_cubit.dart' show ClientLoginCubit;
import '../../../../../profile/presentation/view/pages/profile/client_profile_page.dart';
import '../../../../data/Repo/firebase_service_login_client.dart';
import '../../../../data/Repo/hive_auth_service.dart';
import '../../../view_model/cubit/login/client_login_state.dart';
import '../Custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';
import '../../pages/register/register_screen.dart';
import '../../../../../../core/widgets/custom_button.dart';

class ClientLoginLayout extends StatelessWidget {
  const ClientLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseServiceLoginClient();
    final hiveService = HiveAuthService();

    return BlocProvider(
      create: (_) => ClientLoginCubit(firebaseService, hiveService),
      child: BlocConsumer<ClientLoginCubit, ClientLoginState>(
        listener: (context, state) {
          if (state is ClientLoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ClientLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ClientProfilePage()),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ClientLoginCubit>();
          Map<String, String?> errors = {};
          if (state is ClientLoginValidation) errors = state.errors;
          bool isLoading = state is ClientLoginLoading;
          var size = MediaQuery.of(context).size;

          return Stack(
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
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      text: "Don't have an account? ",
                      textColor: "Register",
                    ),
                  ],
                ),
              ),
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
