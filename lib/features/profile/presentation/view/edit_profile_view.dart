import 'dart:io';

import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/theme/theme_data/theme_data.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/profile/presentation/state/current_user_state.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/current_user_view_model.dart';
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

  File? _image;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with empty strings initially
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    usernameController = TextEditingController();

    // Set the initial values after the controllers are initialized
    final state = ref.read(currentUserViewModelProvider);
    fnameController.text = state.authEntity?.firstName ?? '';
    lnameController.text = state.authEntity?.lastName ?? '';
    emailController.text = state.authEntity?.email ?? '';
    phoneController.text = state.authEntity?.phoneNumber ?? '';
    usernameController.text = state.authEntity?.userName ?? '';
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final theme = isDarkMode ? KAppTheme.darkTheme : KAppTheme.lightTheme;

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: theme.appBarTheme.iconTheme?.color),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Update Profile',
            style: theme.appBarTheme.titleTextStyle,
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: theme.appBarTheme.elevation,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileImage(
                      ref.watch(currentUserViewModelProvider), theme),
                  const SizedBox(height: 40),
                  _buildForm(theme),
                  const SizedBox(height: 20),
                  _buildSaveButton(theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(CurrentUserState state, ThemeData theme) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.colorScheme.primary, width: 3),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 70,
            backgroundImage: _getProfileImage(state),
          ),
        ),
        FloatingActionButton.small(
          onPressed: () => checkCameraPermission(),
          backgroundColor: theme.colorScheme.secondary,
          child: const Icon(Icons.camera_alt),
        ),
      ],
    );
  }

  ImageProvider _getProfileImage(CurrentUserState state) {
    if (_image != null) {
      return FileImage(_image!);
    } else if (state.uploadProfilePicture.isNotEmpty) {
      return NetworkImage(
          '${ApiEndpoints.imageUrlprofile}${state.uploadProfilePicture}');
    } else {
      return const AssetImage('assets/profile_image.jpg');
    }
  }

  Widget _buildForm(ThemeData theme) {
    return Column(
      children: [
        _buildTextField(
            icon: Icons.person,
            hintText: 'First Name',
            controller: fnameController,
            theme: theme),
        const SizedBox(height: 20),
        _buildTextField(
            icon: Icons.person,
            hintText: 'Last Name',
            controller: lnameController,
            theme: theme),
        const SizedBox(height: 20),
        _buildTextField(
            icon: Icons.email,
            hintText: 'E-Mail',
            controller: emailController,
            theme: theme),
        const SizedBox(height: 20),
        _buildTextField(
            icon: Icons.phone,
            hintText: 'Phone No',
            controller: phoneController,
            theme: theme),
        const SizedBox(height: 20),
        _buildTextField(
            icon: Icons.person,
            hintText: 'Username',
            controller: usernameController,
            theme: theme),
      ],
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hintText,
    required TextEditingController controller,
    required ThemeData theme,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: theme.iconTheme.color),
        hintText: hintText,
      ),
    );
  }

  Widget _buildSaveButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: () {
        ref.read(currentUserViewModelProvider.notifier).updateUser(
              AuthEntity(
                id: ref.read(currentUserViewModelProvider).authEntity!.id,
                firstName: fnameController.text,
                userName: usernameController.text,
                lastName: lnameController.text,
                email: emailController.text,
                phoneNumber: phoneController.text,
                profilePicture: ref
                    .watch(currentUserViewModelProvider)
                    .uploadProfilePicture,
              ),
            );
      },
      style: theme.elevatedButtonTheme.style,
      child: const Text('Save Changes'),
    );
  }

  Future<void> checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      _pickImage();
    } else {
      if (await Permission.camera.request().isGranted) {
        _pickImage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Camera permission is required to take pictures')),
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
}
