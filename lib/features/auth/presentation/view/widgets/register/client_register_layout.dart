import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../view_model/cubit/register/client_register_cubit.dart';
import '../../../view_model/cubit/register/client_register_state.dart';
import '../../pages/login/login_page.dart';
import '../custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';

class ClientRegisterPage extends StatelessWidget {
  const ClientRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (_) => ClientRegisterCubit(),
      child: BlocConsumer<ClientRegisterCubit, ClientRegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.watch<ClientRegisterCubit>();
          final size = MediaQuery.of(context).size;
          final isLoading =
              state is ClientRegisterLoading && state.isLoading;

          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: size.height * 0.05),

                        CustomTextFieldLogin(
                          hinText: "Full Name",
                          controller: cubit.nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        CustomTextFieldLogin(
                          hinText: "Date of Birth",
                          controller: cubit.dateController,
                          keyboardType: TextInputType.datetime,
                          suffixIcon: Icons.calendar_today,
                          onSuffixTap: () => cubit.selectDate(context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Date of Birth is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        CustomTextFieldLogin(
                          hinText: "Phone",
                          controller: cubit.phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Phone is required";
                            }
                            if (!RegExp(r'^\d+$').hasMatch(value)) {
                              return "Phone must be digits only";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

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
                        SizedBox(height: 20),

                        CustomTextFieldLogin(
                          hinText: "Password",
                          controller: cubit.passwordController,
                          obscureText: cubit.obscurePassword,
                          suffixIcon: cubit.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onSuffixTap: cubit.togglePassword,
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
                        SizedBox(height: 20),

                        CustomTextFieldLogin(
                          hinText: "Confirm Password",
                          controller: cubit.confirmPasswordController,
                          obscureText: cubit.obscureConfirmPassword,
                          suffixIcon: cubit.obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onSuffixTap: cubit.toggleConfirmPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm Password is required";
                            }
                            if (value != cubit.passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),

                        CustomButton(
                          text: "Create Account",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.createAccount(context);
                            }
                          },
                        ),
                        SizedBox(height: 24),

                        CustomButtonSocial(
                          textSocial: "Continue with Google",
                          icon: Icons.g_mobiledata,
                        ),
                        SizedBox(height: 32),

                        CustomTextRegister(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          text: "Already have an account? ",
                          textColor: "Login",
                        ),
                        SizedBox(height: 80),
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
