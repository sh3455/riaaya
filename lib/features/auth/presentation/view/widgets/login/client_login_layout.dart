import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riaaya_app/core/widgets/custom_button.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/profile/client_profile_page.dart';
import 'package:riaaya_app/features/auth/presentation/view/pages/register/register_screen.dart';
import 'package:riaaya_app/features/auth/presentation/view/widgets/custom_button_social.dart';
import 'package:riaaya_app/features/request_status/presentation/view/pages/request_status_screen.dart';
import '../Custom_text_field_login.dart';
import '../custom_button_social.dart';
import '../custom_text_register.dart';


class ClientLoginLayout extends StatelessWidget {
  const ClientLoginLayout({super.key});

  @override
  State<ClientLoginLayout> createState() => _ClientLoginLayoutState();
}

class _ClientLoginLayoutState extends State<ClientLoginLayout> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Map<String, String?> errors = {'email': null, 'password': null};

  void login() async {
    // Validation
    setState(() {
      errors['email'] = emailController.text.isEmpty ? "This field is required" : null;
      errors['password'] = passwordController.text.isEmpty ? "This field is required" : null;
    });

    if (errors['email'] != null || errors['password'] != null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final uid = userCredential.user!.uid;

      final doc = await FirebaseFirestore.instance.collection('clients').doc(uid).get();

      if (!doc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found in database")),
        );
        await FirebaseAuth.instance.signOut();
        return;
      }

      // الحساب موجود → توجيه المستخدم للـ Profile Page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ClientProfilePage()),
        );
      }

    } on FirebaseAuthException catch (e) {
      String msg;
      if (e.code == 'user-not-found') {
        msg = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        msg = 'Wrong password provided.';
      } else {
        msg = 'Auth Error: ${e.code}';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),

              // Email
              CustomTextFieldLogin(
                hinText: "Email",
                controller: emailController,
              ),
              if (errors['email'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(errors['email']!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                ),

              SizedBox(height: size.height * 0.03),

              // Password
              CustomTextFieldLogin(
                hinText: "Password",
                controller: passwordController,
                obscureText: true,
              ),
              if (errors['password'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(errors['password']!, style: const TextStyle(color: Colors.red, fontSize: 12)),
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
                onTap: login,
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

        // Loading overlay
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            width: size.width,
            height: size.height,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }
}
