import 'package:final_assignment/features/settings/presentation/viewmodel/current_user_view_model.dart';
import 'package:final_assignment/features/settings/presentation/widgets/my_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(currentUserViewModelProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);

    if (currentUserState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (currentUserState.authEntity == null) {
      return const Center(child: Text('No user found'));
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
            child: ProfileDetails(authEntity: authEntity, ref: ref),
          ),
        ),
      );
    }
  }
}
