import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/core/common/widgets/my_appbar.dart';
import 'package:final_assignment/core/common/widgets/t_cart_counter_icon.dart';
import 'package:flutter/material.dart';

class TAppBar extends StatelessWidget {
  const TAppBar({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MyAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to Lensify",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Text(
            "Buy your favorite lens",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.white),
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
          iconColor: TColors.white,
          onPressed: onPressed,
        )
      ],
    );
  }
}
