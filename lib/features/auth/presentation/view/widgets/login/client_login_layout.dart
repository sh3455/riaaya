import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../profile/presentation/view/pages/profile/client_profile_page.dart';
import '../../../../data/Repo/firebase_service_login_client.dart';
import '../../../view_model/cubit/login/client_login_state.dart';
import '../../../view_model/cubit/login/client_login_cubit.dart';
import '../../pages/register/register_screen.dart';
import '../custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';

class ClientLoginLayout extends StatelessWidget {
   ClientLoginLayout({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientLoginCubit(FirebaseServiceLoginClient()),
      child: BlocConsumer<ClientLoginCubit, ClientLoginState>(
        listener: (context, state) {
          if (state is ClientLoginError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ClientLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ClientProfilePage()),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.watch<ClientLoginCubit>();
          final size = MediaQuery.of(context).size;
          final isLoading = state is ClientLoginLoading;

          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.08),

                        // Email
                        CustomTextFieldLogin(
                          hinText: "Email",
                          controller: cubit.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.03),

                        // Password
                        CustomTextFieldLogin(
                          hinText: "Password",
                          controller: cubit.passwordController,
                          obscureText: cubit.isPasswordHidden,
                          suffixIcon: cubit.isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onSuffixTap: cubit.togglePasswordVisibility,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
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

                        CustomButton(
                          text: "Login",
                          onTap: isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login();
                            }
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
                                  builder: (_) => const RegisterScreen()),
                            );
                          },
                          text: "Don't have an account? ",
                          textColor: "Register",
                        ),
                      ],
                    ),
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
