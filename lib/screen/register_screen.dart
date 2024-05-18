// import 'package:final_assignment/screen/login_screen.dart';
// import 'package:flutter/material.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _fNameController = TextEditingController();
//   final _lNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _userNameController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Image(
//                         height: 100,
//                         image: AssetImage("assets/images/applogo2.png"),
//                       ),
//                       //title

//                       const Text(
//                         "Let's Create Your Account",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 32),
//                       Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: Form(
//                                     child: TextFormField(
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return 'Please enter your first name';
//                                         }
//                                         if (value.length < 3) {
//                                           return 'Please enter valid first name';
//                                         }
//                                         if (RegExp(r'^\d+$').hasMatch(value)) {
//                                           return 'Please enter a valid first name';
//                                         }

//                                         return null;
//                                       },
//                                       controller: _fNameController,
//                                       expands: false,
//                                       decoration: InputDecoration(
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         labelText: "First Name",
//                                         prefixIcon: const Icon(Icons.person),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: TextFormField(
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your last name';
//                                       }
//                                       if (value.length < 3) {
//                                         return 'Please enter valid last name';
//                                       }
//                                       if (RegExp(r'^\d+$').hasMatch(value)) {
//                                         return 'Please enter a valid last name';
//                                       }

//                                       return null;
//                                     },
//                                     controller: _lNameController,
//                                     expands: false,
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       labelText: "Last Name",
//                                       prefixIcon: const Icon(Icons.person),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your last name';
//                                 }
//                                 if (value.length < 3) {
//                                   return 'Please enter valid last name';
//                                 }
//                                 if (RegExp(r'^\d+$').hasMatch(value)) {
//                                   return 'Please enter a valid last name';
//                                 }

//                                 return null;
//                               },
//                               controller: _emailController,
//                               expands: false,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 labelText: "Email",
//                                 prefixIcon: const Icon(Icons.email),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your user name';
//                                 }
//                                 if (value.length < 3) {
//                                   return 'Please enter valid user name';
//                                 }

//                                 return null;
//                               },
//                               controller: _userNameController,
//                               expands: false,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 labelText: "User Name",
//                                 prefixIcon:
//                                     const Icon(Icons.person_add_alt_outlined),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your  phone number';
//                                 }
//                                 if (value.length < 10) {
//                                   return 'Please enter valid phone number';
//                                 }
//                                 return null;
//                               },
//                               controller: _phoneNumberController,
//                               expands: false,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 labelText: "Phone Number",
//                                 prefixIcon: const Icon(Icons.phone_android),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your password';
//                                 }
//                                 if (value.length < 6) {
//                                   return 'Please enter valid password';
//                                 }

//                                 return null;
//                               },
//                               controller: _passwordController,
//                               expands: false,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 labelText: "Password",
//                                 prefixIcon: const Icon(Icons.password),
//                                 suffixIcon: const Icon(Icons.remove_red_eye),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: 24,
//                                   height: 24,
//                                   child: Checkbox(
//                                     value: true,
//                                     onChanged: (value) {},
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 19,
//                                 ),
//                                 const Text.rich(
//                                   TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: "I agree to the ",
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                       TextSpan(
//                                         text: "Privacy Policy ",
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 3, 139, 251),
//                                           decoration: TextDecoration.underline,
//                                           decorationColor:
//                                               Color.fromARGB(255, 3, 139, 251),
//                                         ),
//                                       ),
//                                       TextSpan(
//                                         text: "and ",
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                       TextSpan(
//                                         text: "Terms of use ",
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 3, 139, 251),
//                                           decoration: TextDecoration.underline,
//                                           decorationColor:
//                                               Color.fromARGB(255, 3, 139, 251),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 32,
//                             ),
//                             SizedBox(
//                               width: double.infinity,
//                               height: 50,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         const Color.fromARGB(255, 3, 139, 251),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     )),
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     final email = _emailController.text;
//                                     final password = _passwordController.text;

//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           title: const Text('Login'),
//                                           content: Text(
//                                               'Email: $email\nPassword: $password'),
//                                           actions: [
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         const LoginScreen(),
//                                                   ),
//                                                 );
//                                               },
//                                               child: const Text('OK'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   }
//                                 },
//                                 child: const Text(
//                                   'Create Account',
//                                   style: TextStyle(
//                                       fontSize: 20, color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:final_assignment/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                                  child: TextFormField(
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
                                    controller: _fNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: "First Name",
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
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
                                    controller: _lNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      labelText: "Last Name",
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
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
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Email",
                                prefixIcon: const Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                if (value.length < 3) {
                                  return 'Please enter a valid username';
                                }
                                return null;
                              },
                              controller: _userNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "User Name",
                                prefixIcon:
                                    const Icon(Icons.person_add_alt_outlined),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Phone Number",
                                prefixIcon: const Icon(Icons.phone_android),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: const Icon(Icons.remove_red_eye),
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
                                const Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "I agree to the ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: "Privacy Policy ",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 3, 139, 251),
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
                                          color:
                                              Color.fromARGB(255, 3, 139, 251),
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              Color.fromARGB(255, 3, 139, 251),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 139, 251),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DashboardScreen(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
