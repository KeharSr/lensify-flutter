import 'package:flutter/material.dart';

class MyAppBarIcon extends StatelessWidget {
  const MyAppBarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.shopify_sharp, color: Colors.white,),),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
                child: Text('2', style: TextStyle(color: Colors.white, fontSize: 12,),)
            ),

          ),
        )


      ],
    );
  }
}
