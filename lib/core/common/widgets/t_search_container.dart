import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          color: showBackground
              ? dark
                  ? TColors.dark
                  : TColors.light
              : Colors.transparent,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: showBorder
              ? Border.all(
                  color: TColors.grey,
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(Iconsax.search_normal, color: TColors.darkerGrey),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('Search in Store',
                style: Theme.of(context).textTheme.bodySmall!),
          ],
        ),
      ),
    );
  }
}
