// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class ImageCarosel extends StatefulWidget {
  const ImageCarosel({super.key});

  @override
  _ImageCaroselState createState() => _ImageCaroselState();
}

class _ImageCaroselState extends State<ImageCarosel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  final List<String> imageList = [
    

    'assets/images/phone2.webp',
    'assets/images/phone1.jpg',
    'assets/images/phone2.webp',
    
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageList
          .map((item) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:Image.asset(item)
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio:2.2/1.4,
        autoPlayInterval: const Duration(seconds: 2),
        animateToClosest: true,
        viewportFraction: 0.85,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        pageSnapping: true,
        enlargeFactor: 0.01,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      carouselController: _controller,
    );
  }
}
