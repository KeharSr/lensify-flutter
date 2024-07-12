import 'package:final_assignment/features/product/presentation/view_model/products_viewmodel.dart';
import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_menu_item.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile image
              const SizedBox(height: 10),
              currentUserState.isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      '${currentUserState.authEntity!.firstName} ${currentUserState.authEntity!.lastName}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 20),

              ProfileMenuItem(
                  icon: Icons.fingerprint,
                  text: 'Enable Fingerprint',
                  textColor: Colors.red,
                  onTap: () {
                    ref
                        .read(currentUserViewModelProvider.notifier)
                        .enableFingerprint();
                  }),

              const Divider(),
              ProfileMenuItem(
                  icon: Icons.delete,
                  text: 'Delete Account',
                  onTap: () {},
                  textColor: Colors.red),
              ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    ref.read(productViewModelProvider.notifier).logout();
                  },
                  textColor: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}
