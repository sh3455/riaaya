import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../profile/presentation/view/pages/profile/profile_nurse.dart';
import '../../../../data/Repo/firebase_service-login_nurse.dart';
import '../../../view_model/cubit/login/nurse_login_cubit.dart';
import '../custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';
import '../../pages/register/register_screen.dart';
import '../../../../../../core/widgets/custom_button.dart';

class NurseLoginLayout extends StatelessWidget {
  const NurseLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (_) => NurseLoginCubit(NurseAuthRepository()),
      child: BlocConsumer<NurseLoginCubit, NurseLoginState>(
        listener: (context, state) {
          if (state is NurseLoginError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is NurseLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NurseProfilePage()),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.watch<NurseLoginCubit>();
          final size = MediaQuery.of(context).size;
          final isLoading = state is NurseLoginLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.08),

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
                              builder: (_) => const RegisterScreen(),
                            ),
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
          );
        },
      ),
    );
  }
}
