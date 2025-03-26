import 'package:flutter/material.dart';
import 'package:car_carousel_app/widget/car_carousel.dart';



class CarCarouselScreen extends StatelessWidget {
  const CarCarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Carousel',
        style:TextStyle( fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black87),),
      ),
  
      body: Center(
        child:SingleChildScrollView(
        child: CarCarousel(),
      ),
    )
    );
  }
}
