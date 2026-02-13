import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../view_model/cubit/register/nurse_register_cubit.dart';
import '../../../view_model/cubit/register/nurse_register_state.dart';
import '../../pages/login/login_page.dart';
import '../custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';
import '../../../../../../core/widgets/custom_button.dart';

class NurseRegisterLayout extends StatelessWidget {
  NurseRegisterLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => NurseRegisterCubit(),
      child: BlocConsumer<NurseRegisterCubit, NurseRegisterState>(
        listener: (context, state) {
          if (state is NurseRegisterSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<NurseRegisterCubit>();
          Map<String, String?> errors = {};
          if (state is NurseRegisterValidation) errors = state.errors;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),

                    CustomTextFieldLogin(
                      hinText: "Full Name",
                      controller: cubit.nameController,
                    ),
                    if (errors['name'] != null)
                      Text(errors['name']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.02),
                    CustomTextFieldLogin(
                      hinText: "Date of Birth",
                      controller: cubit.birthController,
                      suffixIcon: Icons.calendar_today,
                      onSuffixTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          cubit.birthController.text =
                          "${picked.year}-${picked.month}-${picked.day}";
                        }
                      },
                    ),
                    if (errors['birth'] != null)
                      Text(errors['birth']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.02),
                    CustomTextFieldLogin(
                      hinText: "Location",
                      controller: cubit.locationController,
                    ),
                    if (errors['location'] != null)
                      Text(errors['location']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.02),
                    CustomTextFieldLogin(
                      hinText: "Experience",
                      controller: cubit.experienceController,
                    ),
                    if (errors['experience'] != null)
                      Text(errors['experience']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.02),
                    CustomTextFieldLogin(
                      hinText: "Phone",
                      controller: cubit.phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    if (errors['phone'] != null)
                      Text(errors['phone']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.02),
                    CustomTextFieldLogin(
                      hinText: "Email",
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    if (errors['email'] != null)
                      Text(errors['email']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.02),
                    CustomTextFieldLogin(
                      hinText: "Password",
                      controller: cubit.passwordController,
                      obscureText: cubit.obscurePassword,
                      suffixIcon: cubit.obscurePassword ? Icons.visibility_off : Icons.visibility,
                      onSuffixTap: cubit.togglePassword,
                    ),
                    if (errors['password'] != null)
                      Text(errors['password']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.02),
                    CustomTextFieldLogin(
                      hinText: "Confirm Password",
                      controller: cubit.confirmPasswordController,
                      obscureText: cubit.obscureConfirmPassword,
                      suffixIcon: cubit.obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      onSuffixTap: cubit.toggleConfirmPassword,
                    ),
                    if (errors['confirmPassword'] != null)
                      Text(errors['confirmPassword']!, style: const TextStyle(color: Colors.red, fontSize: 12)),

                    SizedBox(height: size.height * 0.03),
                    CustomButton(
                      text: "Create Account",
                      onTap: cubit.createAccount,
                    ),
                  ],
                ),
              ),
              if (state is NurseRegisterLoading)
                Container(
                  color: Colors.black.withOpacity(0.4),
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
