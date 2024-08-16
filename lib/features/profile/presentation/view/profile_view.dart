import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/core/common/widgets/my_curved_edges.dart';
import 'package:final_assignment/features/my_orders/presentation/view/order_view.dart';
import 'package:final_assignment/features/product/presentation/view_model/products_viewmodel.dart';
import 'package:final_assignment/features/profile/presentation/view/edit_profile_view.dart';
import 'package:final_assignment/features/profile/presentation/viewmodel/current_user_view_model.dart';
import 'package:final_assignment/features/profile/presentation/widgets/my_profile_view.dart';
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
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(currentUserViewModelProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    if (currentUserState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (currentUserState.authEntity == null) {
      return const Center(child: Text('No user found'));
    } else {
      final authEntity = currentUserState.authEntity!;

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: MyCurvedEdges(),
                    child: Container(
                      height: 260,
                      color: TColors.primary,
                    ),
                  ),
                  const Positioned(
                    top: 40,
                    left: 16,
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: TColors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 16,
                    child: IconButton(
                      icon: const Icon(Iconsax.edit, color: TColors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfileView()));
                      },
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: authEntity.profilePicture != null &&
                                  authEntity.profilePicture!.isNotEmpty
                              ? NetworkImage(
                                  '${ApiEndpoints.imageUrlprofile}${authEntity.profilePicture}')
                              : const AssetImage(
                                      'assets/placeholder_profile_image.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${authEntity.firstName} ${authEntity.lastName}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: TColors.white,
                          ),
                        ),
                        Text(
                          authEntity.email,
                          style: TextStyle(
                            fontSize: 14,
                            color: TColors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProfileDetails(
                  authEntity: authEntity,
                  ref: ref,
                  onMyCartTap: () {
                    ref.read(productViewModelProvider.notifier).openCartView();
                  },
                  onMyOrdersTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyOrdersView()));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}