// import 'dart:io';

// import 'package:final_assignment/app/constants/api_endpoint.dart';
// import 'package:final_assignment/app/constants/colors.dart';
// import 'package:final_assignment/features/settings/presentation/state/current_user_state.dart';
// import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class EditProfileView extends ConsumerStatefulWidget {
//   const EditProfileView({super.key});

//   @override
//   _EditProfileViewState createState() => _EditProfileViewState();
// }

// class _EditProfileViewState extends ConsumerState<EditProfileView> {
//   late TextEditingController fnameController;
//   late TextEditingController lnameController;
//   late TextEditingController emailController;
//   late TextEditingController phoneController;

//   File? _image;

//   Future<void> checkCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (status.isGranted) {
//       _pickImage();
//     } else if (status.isDenied ||
//         status.isRestricted ||
//         status.isPermanentlyDenied) {
//       if (await Permission.camera.request().isGranted) {
//         _pickImage();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Camera permission is required to take pictures'),
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       ref
//           .read(currentUserViewModelProvider.notifier)
//           .uploadProfilePicture(_image!);
//     }
//   }

//   @override
//   initState() {
//     fnameController = TextEditingController();
//     lnameController = TextEditingController();
//     emailController = TextEditingController();
//     phoneController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(currentUserViewModelProvider);

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: TColors.primary),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Update Profile',
//           style: TextStyle(color: TColors.primary, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 _buildProfileImage(state),
//                 const SizedBox(height: 40),
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         _buildTextField(
//                             icon: Icons.person,
//                             hintText: 'First Name',
//                             value: state.authEntity!.firstName,
//                             controller: fnameController),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                             icon: Icons.person,
//                             hintText: 'Last Name',
//                             value: state.authEntity!.lastName,
//                             controller: lnameController),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                             icon: Icons.email,
//                             hintText: 'E-Mail',
//                             value: state.authEntity!.email,
//                             controller: lnameController),
//                         const SizedBox(height: 20),
//                         _buildTextField(
//                             icon: Icons.phone,
//                             hintText: 'Phone No',
//                             value: state.authEntity!.phoneNumber,
//                             controller: phoneController),
//                         const SizedBox(height: 40),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Add functionality to save profile changes
//                           },
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.white,
//                             backgroundColor: TColors.primary,
//                             minimumSize: const Size(double.infinity, 55),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             elevation: 5,
//                             padding: const EdgeInsets.symmetric(vertical: 15),
//                           ),
//                           child: const Text('Save Changes',
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold)),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 if (state.error != null && state.error!.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: Text(
//                       'Failed to upload image: ${state.error}',
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 if (state.uploadProfilePicture.isNotEmpty)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 16.0),
//                     child: Text(
//                       'Image uploaded successfully',
//                       style: TextStyle(color: Colors.green),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileImage(CurrentUserState state) {
//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: TColors.primary, width: 3),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 spreadRadius: 2,
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: CircleAvatar(
//             radius: 70,
//             backgroundImage: _image != null
//                 ? FileImage(_image!)
//                 : state.uploadProfilePicture.isNotEmpty
//                     ? NetworkImage(
//                         '${ApiEndpoints.imageUrlprofile}${state.uploadProfilePicture}',
//                       ) as ImageProvider
//                     : const AssetImage('assets/profile_image.jpg'),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: TColors.primary,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
//             onPressed: () {
//               checkCameraPermission();
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField(
//       {required IconData icon,
//       required String hintText,
//       bool isPassword = false,
//       required TextEditingController? controller,
//       required String? value}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         initialValue: value,
//         controller: controller,
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: TColors.primary),
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey[400]),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//           filled: true,
//           fillColor: Colors.grey[50],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/settings/presentation/state/current_user_state.dart';
import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  File? _image;

  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      _pickImage();
    } else if (status.isDenied ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      if (await Permission.camera.request().isGranted) {
        _pickImage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera permission is required to take pictures'),
          ),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      ref
          .read(currentUserViewModelProvider.notifier)
          .uploadProfilePicture(_image!);
    }
  }

  @override
  initState() {
    super.initState();
    final state = ref.read(currentUserViewModelProvider);
    fnameController = TextEditingController(text: state.authEntity?.firstName);
    lnameController = TextEditingController(text: state.authEntity?.lastName);
    emailController = TextEditingController(text: state.authEntity?.email);
    phoneController =
        TextEditingController(text: state.authEntity?.phoneNumber);
    usernameController =
        TextEditingController(text: state.authEntity?.userName);

    passwordController =
        TextEditingController(text: state.authEntity?.password);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currentUserViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: TColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Update Profile',
          style: TextStyle(color: TColors.primary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(state),
                const SizedBox(height: 40),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextField(
                            icon: Icons.person,
                            hintText: 'First Name',
                            controller: fnameController),
                        const SizedBox(height: 20),
                        _buildTextField(
                            icon: Icons.person,
                            hintText: 'Last Name',
                            controller: lnameController),
                        const SizedBox(height: 20),
                        _buildTextField(
                            icon: Icons.email,
                            hintText: 'E-Mail',
                            controller: emailController),
                        const SizedBox(height: 20),
                        _buildTextField(
                            icon: Icons.phone,
                            hintText: 'Phone No',
                            controller: phoneController),
                        const SizedBox(height: 40),

                        // Add username and password fields
                        _buildTextField(
                            icon: Icons.person,
                            hintText: 'Username',
                            controller: usernameController),
                        const SizedBox(height: 20),

                        _buildTextField(
                            icon: Icons.lock,
                            hintText: 'Password',
                            isPassword: true,
                            controller: passwordController),

                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(currentUserViewModelProvider.notifier)
                                .updateUser(
                                  AuthEntity(
                                    //get the user id from the authEntity
                                    id: state.authEntity!.id,
                                    firstName: fnameController.text,
                                    userName: usernameController.text,
                                    lastName: lnameController.text,
                                    email: emailController.text,
                                    phoneNumber: phoneController.text,
                                    password: passwordController.text,
                                  ),
                                );
                            // Add functionality to save profile changes
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: TColors.primary,
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text('Save Changes',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    );
                  },
                ),
                if (state.error != null && state.error!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Failed to upload image: ${state.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (state.uploadProfilePicture.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Image uploaded successfully',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(CurrentUserState state) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: TColors.primary, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 70,
            backgroundImage: _image != null
                ? FileImage(_image!)
                : state.uploadProfilePicture.isNotEmpty
                    ? NetworkImage(
                        '${ApiEndpoints.imageUrlprofile}${state.uploadProfilePicture}',
                      ) as ImageProvider
                    : const AssetImage('assets/profile_image.jpg'),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: TColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
            onPressed: () {
              checkCameraPermission();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      {required IconData icon,
      required String hintText,
      bool isPassword = false,
      required TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: TColors.primary),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),
    );
  }
}
