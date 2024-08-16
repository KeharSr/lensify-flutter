// import 'package:final_assignment/app/constants/colors.dart';
// import 'package:final_assignment/app/constants/sizes.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
//
// class TSearchContainer extends StatelessWidget {
//   const TSearchContainer({
//     super.key,
//     required this.text,
//     this.icon = Iconsax.search_normal,
//     this.showBackground = true,
//     this.showBorder = true,
//   });
//
//   final String text;
//   final IconData? icon;
//   final bool showBackground, showBorder;
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = Theme.of(context).brightness == Brightness.dark;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: text,
//           prefixIcon: Icon(icon, color: TColors.darkerGrey),
//           filled: showBackground,
//           fillColor: showBackground
//               ? dark
//                   ? TColors.dark
//                   : TColors.light
//               : Colors.transparent,
//           border: showBorder
//               ? OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
//                   borderSide: BorderSide(color: TColors.grey),
//                 )
//               : InputBorder.none,
//           contentPadding: const EdgeInsets.all(TSizes.md),
//           isDense: true,
//         ),
//         style: Theme.of(context).textTheme.bodySmall!,
//       ),
//     );
//   }
// }

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
    this.onChanged,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: SizedBox(
        height: 55, // Adjust the height value as needed
        child: TextField(
          onChanged: (value) {
            onChanged!(value);
          },
          decoration: InputDecoration(
            hintText: text,
            prefixIcon: Icon(icon, color: TColors.darkerGrey),
            filled: showBackground,
            fillColor: showBackground
                ? dark
                    ? TColors.dark
                    : TColors.light
                : Colors.transparent,
            border: showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
                    borderSide: BorderSide(color: TColors.grey),
                  )
                : InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: TSizes.md,
            ),
            isDense: true,
          ),
          style: Theme.of(context).textTheme.bodySmall!,
        ),
      ),
    );
  }
}
