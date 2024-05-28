

import 'package:final_assignment/common/widgets/my_button.dart';
import 'package:final_assignment/common/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    height: 100,
                    image: AssetImage("assets/images/applogo2.png"),
                  ),
                  const Text(
                    "Let's Create Your Account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: MyTextFormField(
                                controller: _fNameController,
                                labelText: "First Name",
                                prefixIcon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  if (value.length < 3) {
                                    return 'Please enter a valid first name';
                                  }
                                  if (RegExp(r'^\d+$').hasMatch(value)) {
                                    return 'Please enter a valid first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: MyTextFormField(
                                controller: _lNameController,
                                labelText: "Last Name",
                                prefixIcon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  if (value.length < 3) {
                                    return 'Please enter a valid last name';
                                  }
                                  if (RegExp(r'^\d+$').hasMatch(value)) {
                                    return 'Please enter a valid last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        MyTextFormField(
                          controller: _emailController,
                          labelText: "Email",
                          prefixIcon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        MyTextFormField(
                          controller: _userNameController,
                          labelText: "User Name",
                          prefixIcon: Icons.person_add_alt_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            if (value.length < 3) {
                              return 'Please enter a valid username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        MyTextFormField(
                          controller: _phoneNumberController,
                          labelText: "Phone Number",
                          prefixIcon: Icons.phone_android,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        MyTextFormField(
                          controller: _passwordController,
                          labelText: "Password",
                          prefixIcon: Icons.password_sharp,
                          obscureText: _obscureText,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 5) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: true,
                                onChanged: (value) {},
                              ),
                            ),
                            const SizedBox(width: 19),
                            const Flexible(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree to the ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "Privacy Policy ",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 3, 139, 251),
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Color.fromARGB(255, 3, 139, 251),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "and ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: "Terms of use ",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 3, 139, 251),
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Color.fromARGB(255, 3, 139, 251),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        MyButton(
                          backgroundColor:
                              const Color.fromARGB(255, 1, 141, 255),
                          text: 'Create Account',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text("Already have an account? "),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 3, 139, 251),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
