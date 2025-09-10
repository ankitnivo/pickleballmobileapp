import 'package:flutter/material.dart';
import 'package:pickleballmobileapp/screens/home_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _agree = false;

  InputDecoration _pillDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.black26),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('lib/assests/VERSYON-LOGO-01.png'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Hello!",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Username
                    TextFormField(
                      decoration: _pillDecoration("Username", Icons.person_outline),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Please enter a username' : null,
                    ),
                    const SizedBox(height: 15),

                    // Email
                    TextFormField(
                      decoration: _pillDecoration("Email", Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your email';
                        final reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        return reg.hasMatch(value) ? null : 'Please enter a valid email';
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password
                    TextFormField(
                      decoration: _pillDecoration("Password", Icons.lock_outline),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter your password';
                        if (value.length < 8) return 'Password must be at least 8 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // Terms (validated)
                    FormField<bool>(
                      initialValue: _agree,
                      validator: (v) => (v ?? false) ? null : 'Please accept the terms',
                      builder: (state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              value: state.value ?? false,
                              onChanged: (val) {
                                setState(() {
                                  _agree = val ?? false;
                                  state.didChange(_agree);
                                });
                              },
                              title: const Text(
                                "I agree to the terms and conditions",
                                style: TextStyle(fontSize: 12),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(left: 12, top: 2),
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),

                    // Sign Up
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                           Navigator.pushReplacement(context, 
                           MaterialPageRoute(builder: (context)=>HomeScreen())
                           );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Divider with OR
                    Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Or"),
                        ),
                        Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Social in Row
                    buildOptionSignIn(context),

                    const SizedBox(height: 20),

                    const Text(
                      "Log in with your iOS or Android account",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildOptionSignIn(BuildContext context) {
  // Use Row with Expanded so both buttons share width; use custom child Row to control icon/label gap.
  return Row(
    children: [
      Expanded(
        child: OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Google Sign In will be implemented')),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(26, 28, 30, 1),
            side: const BorderSide(color: Color.fromRGBO(116, 119, 127, 1)),
            minimumSize: const Size(0, 48),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.g_mobiledata, size: 24, color: Colors.red),
              SizedBox(width: 8),
              Flexible(child: Text('Continue with Google')),
            ],
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Apple Sign In will be implemented')),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(26, 28, 30, 1),
            side: const BorderSide(color: Color.fromRGBO(116, 119, 127, 1)),
            minimumSize: const Size(0, 48),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.apple, size: 20, color: Colors.black),
              SizedBox(width: 8),
              Flexible(child: Text('Continue with Apple')),
            ],
          ),
        ),
      ),
    ],
  );
}
