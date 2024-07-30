// import 'package:final_assignment/features/product/presentation/view_model/products_viewmodel.dart';
// import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../widgets/profile_menu_item.dart';
//
// class ProfileView extends ConsumerStatefulWidget {
//   const ProfileView({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends ConsumerState<ProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     final currentUserState = ref.watch(currentUserViewModelProvider);
//     return SizedBox.expand(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//
//               // Profile image
//               const SizedBox(height: 10),
//               currentUserState.isLoading
//                   ? const CircularProgressIndicator()
//                   : Text(
//                       '${currentUserState.authEntity!.firstName} ${currentUserState.authEntity!.lastName}',
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//               const SizedBox(height: 20),
//
//               ProfileMenuItem(
//                   icon: Icons.fingerprint,
//                   text: 'Enable Fingerprint',
//                   textColor: Colors.red,
//                   onTap: () {
//                     ref
//                         .read(currentUserViewModelProvider.notifier)
//                         .enableFingerprint();
//                   }),
//
//               const Divider(),
//               ProfileMenuItem(
//                   icon: Icons.delete,
//                   text: 'Delete Account',
//                   onTap: () {},
//                   textColor: Colors.red),
//               ProfileMenuItem(
//                   icon: Icons.logout,
//                   text: 'Logout',
//                   onTap: () {
//                     ref.read(productViewModelProvider.notifier).logout();
//                   },
//                   textColor: Colors.red),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/features/product/presentation/view_model/products_viewmodel.dart';
import 'package:final_assignment/features/settings/presentation/view/edit_profile_view.dart';
import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);

    if (currentUserState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      final authEntity = currentUserState.authEntity!;

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref
                    .read(currentUserViewModelProvider.notifier)
                    .getCurrentUser();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: authEntity.profilePicture != null &&
                          authEntity.profilePicture!.isNotEmpty
                      ? NetworkImage(
                          '${ApiEndpoints.imageUrlprofile}${authEntity.profilePicture}')
                      : const AssetImage('assets/placeholder_profile_image.png')
                          as ImageProvider, // Provide a placeholder image
                ),
                const SizedBox(height: 16),
                Text(
                  '${authEntity.firstName} ${authEntity.lastName}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  authEntity.email,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileView()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: TColors.primary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(height: 24),
                _buildMenuItem(Icons.settings, 'Settings', () {}),
                _buildMenuItem(Icons.credit_card, 'Billing Details', () {}),
                _buildMenuItem(Icons.group, 'User Management', () {}),
                _buildMenuItem(Icons.info, 'Information', () {}),
                _buildMenuItem(Iconsax.finger_scan, 'Enable FingerPrint', () {
                  ref
                      .read(currentUserViewModelProvider.notifier)
                      .enableFingerprint();
                }, color: Colors.red),
                _buildMenuItem(Iconsax.logout, 'Logout', () {
                  ref.read(productViewModelProvider.notifier).logout();
                }, color: Colors.red),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blue),
      title: Text(title, style: TextStyle(color: color)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
