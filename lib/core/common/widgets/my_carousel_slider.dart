import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCarouselSlider extends StatelessWidget {
  const MyCarouselSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index, reason) {},
      ),
      items: [
        'https://img.freepik.com/free-vector/colorful-3d-spromotional-sale-wallpaper_23-2148410530.jpg?t=st=1719635271~exp=1719638871~hmac=e5fb1441e1970e118b2e2dc0738210019b03bca03473c2ee0256eb83cf4f93f6&w=996',
        'https://img.freepik.com/free-vector/gradient-ophthalmologist-banner-template_23-2149378793.jpg?ga=GA1.1.1913340666.1719635261&semt=ais_user',
        'https://img.freepik.com/free-photo/designed-sunglasses-red-book-grey-surface_140725-14161.jpg?ga=GA1.1.1913340666.1719635261&semt=ais_user',
      ].map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
