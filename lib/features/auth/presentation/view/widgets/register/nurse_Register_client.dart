import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../../core/widgets/custom_button.dart';
import '../../pages/login/login_page.dart';
import '../Custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';

class NurseRegisterLayout extends StatefulWidget {
  const NurseRegisterLayout({super.key});

  @override
  State<NurseRegisterLayout> createState() => _NurseRegisterLayoutState();
}

class _NurseRegisterLayoutState extends State<NurseRegisterLayout> {
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final locationController = TextEditingController();
  final experienceController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  Future<void> selectBirthDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      birthController.text =
      "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  Future<void> createAccount() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('nurses')
          .doc(credential.user!.uid)
          .set({
        'uid': credential.user!.uid,
        'name': nameController.text.trim(),
        'birth': birthController.text.trim(),
        'location': locationController.text.trim(),
        'experience': experienceController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
        'role': 'nurse',
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Auth error")),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Full Name",
                controller: nameController,
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Date of Birth",
                controller: birthController,
                suffixIcon: Icons.calendar_today,
                onSuffixTap: selectBirthDate,
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Location",
                controller: locationController,
                suffixIcon: Icons.location_on,
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Experience",
                controller: experienceController,
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Phone",
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Password",
                controller: passwordController,
                obscureText: isPasswordHidden,
                suffixIcon: isPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility,
                onSuffixTap: () {
                  setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),
              CustomTextFieldLogin(
                hinText: "Confirm Password",
                controller: confirmPasswordController,
                obscureText: isConfirmPasswordHidden,
                suffixIcon: isConfirmPasswordHidden
                    ? Icons.visibility_off
                    : Icons.visibility,
                onSuffixTap: () {
                  setState(() {
                    isConfirmPasswordHidden =
                    !isConfirmPasswordHidden;
                  });
                },
              ),
              SizedBox(height: size.height * 0.03),
              CustomButton(
                text: "Create Account",
                onTap: createAccount,
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
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                text: "Already have an account? ",
                textColor: "Login",
              ),
            ],
          ),
        ),

        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
