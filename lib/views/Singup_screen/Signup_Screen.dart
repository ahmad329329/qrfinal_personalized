import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrfinal_personalized/res/routes/routes_names.dart';
import '../../../utils/utils.dart';
import '../../controllers/signupController.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  final signUpController = Get.find<SignupController>();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create an\naccount",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),

                // ✅ Name Field
                TextField(
                  controller: signUpController.nameController.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ Registration No Field
                TextField(
                  controller: signUpController.regNoController.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.badge_outlined),
                    hintText: "Registration No",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ Degree Field
                TextField(
                  controller: signUpController.degreeController.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.school_outlined),
                    hintText: "Degree",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ Email Field
                TextField(
                  controller: signUpController.emailController.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ Password Field
                TextField(
                  controller: signUpController.passwordController.value,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ✅ Confirm Password Field
                TextField(
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ Signup Button
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: signUpController.loading.value
                        ? null
                        : () {
                      // Check confirm password
                      if (signUpController.passwordController.value.text !=
                          confirmPasswordController.text) {
                        Utils.snackbar('Error',
                            'Password and Confirm Password do not match');
                        return;
                      }
                      signUpController.signupApi();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: signUpController.loading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )),
                const SizedBox(height: 40),

                // ✅ Go to Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("I Already Have an Account "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.loginScreen);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
