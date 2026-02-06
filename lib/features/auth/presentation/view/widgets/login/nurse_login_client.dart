import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../Custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';
import '../../pages/register/register_screen.dart';

class NurseLoginLayout extends StatefulWidget {
  const NurseLoginLayout({super.key});

  @override
  State<NurseLoginLayout> createState() => _NurseLoginLayoutState();
}

class _NurseLoginLayoutState extends State<NurseLoginLayout> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("Nurse login successful! UID: ${userCredential.user!.uid}");

      // بعد تسجيل الدخول ممكن توجه للـ Nurse Dashboard
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NurseHomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No nurse found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
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
    return Column(
      children: [
        SizedBox(height: size.height * 0.03),
        CustomTextFieldLogin(hinText: "Email", controller: emailController),
        SizedBox(height: size.height * 0.03),
        CustomTextFieldLogin(hinText: "Password", controller: passwordController),
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
          text: "Login",
          onTap: login,
        ),
        SizedBox(height: size.height * 0.05),
        CustomButtonSocial(textSocial: "Continue with Google", icon: Icons.g_mobiledata),
        SizedBox(height: size.height * 0.01),
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
    );
  }
}
