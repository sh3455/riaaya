import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../view_model/cubit/client_register_cubit.dart';
import '../../../view_model/cubit/client_register_state.dart';
import '../../pages/login/login_page.dart';
import '../Custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';

class ClientRegisterPage extends StatelessWidget {
  const ClientRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientRegisterCubit(),
      child: BlocBuilder<ClientRegisterCubit, ClientRegisterState>(
        builder: (context, state) {
          print("Current state is: $state");
          final cubit = context.read<ClientRegisterCubit>();

          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.vertical,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        CustomTextFieldLogin(
                          hinText: "Full Name",
                          controller: cubit.nameController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldLogin(
                          hinText: "Date of Birth",
                          controller: cubit.dateController,
                          keyboardType: TextInputType.datetime,
                          suffixIcon: Icons.calendar_today,
                          onSuffixTap: () => cubit.selectDate(context),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldLogin(
                          hinText: "Phone",
                          controller: cubit.phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldLogin(
                          hinText: "Email",
                          controller: cubit.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldLogin(
                          hinText: "Password",
                          controller: cubit.passwordController,
                          obscureText: cubit.obscurePassword,
                          suffixIcon: cubit.obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixTap: cubit.togglePassword,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFieldLogin(
                          hinText: "Confirm Password",
                          controller: cubit.confirmPasswordController,
                          obscureText: cubit.obscureConfirmPassword,
                          suffixIcon: cubit.obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixTap: cubit.toggleConfirmPassword,
                        ),
                        const SizedBox(height: 40),
                        CustomButton(
                          text: "Create Account",
                          onTap: () => cubit.createAccount(context),
                        ),
                        const SizedBox(height: 24),
                        CustomButtonSocial(
                          textSocial: "Continue with Google",
                          icon: Icons.g_mobiledata,
                        ),
                        const SizedBox(height: 32),
                        CustomTextRegister(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          },
                          text: "Already have an account? ",
                          textColor: "Login",
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),

                if (state is ClientRegisterLoading && state.isLoading)
                  Container(
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