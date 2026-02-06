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

  void createAccount() async {
    if (passwordController.text != confirmPasswordController.text) {
      print("Passwords do not match!");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 1️⃣ إنشاء الحساب في Firebase Auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 2️⃣ تخزين باقي البيانات في Firestore باستخدام UID
      await FirebaseFirestore.instance.collection('nurses').doc(credential.user!.uid).set({
        'name': nameController.text.trim(),
        'birth': birthController.text.trim(),
        'location': locationController.text.trim(),
        'experience': experienceController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
      });

      print("Nurse account created successfully!");

      // 3️⃣ Redirect للـ LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('Auth Error: ${e.code}');
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Full Name", controller: nameController),
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Date of Birth", controller: birthController),
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Location", controller: locationController),
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Experience", controller: experienceController),
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Phone", controller: phoneController),
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Email", controller: emailController),
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Password", controller: passwordController),
          SizedBox(height: size.height * 0.03),
          CustomTextFieldLogin(hinText: "Confirm Password", controller: confirmPasswordController),
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
          isLoading
              ? const CircularProgressIndicator()
              : CustomButton(
            text: "Create Account",
            onTap: createAccount,
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
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            text: "Already have an account? ",
            textColor: "Login",
          ),
        ],
      ),
    );
  }
}
