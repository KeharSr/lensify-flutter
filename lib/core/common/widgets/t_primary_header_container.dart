import 'package:final_assignment/app/constants/colors.dart';
import 'package:final_assignment/core/common/widgets/t_circular_container.dart';
import 'package:final_assignment/core/common/widgets/t_curved_edges_widget.dart';
import 'package:flutter/material.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TCurvedEdgeWidget(
          child: Container(
            color: TColors.primary,
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                      top: -150,
                      right: -250,
                      child: TCircularContainer(
                        backgroundColor: TColors.textWhite.withOpacity(0.1),
                      )),
                  Positioned(
                      top: 100,
                      right: -300,
                      child: TCircularContainer(
                        backgroundColor: TColors.textWhite.withOpacity(0.1),
                      )),
                ],
              ),
            ),
          ),
        ),
        // Positioned widget to ensure the child widget appears on top of the header
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        ),
      ],
    );
  }
}
