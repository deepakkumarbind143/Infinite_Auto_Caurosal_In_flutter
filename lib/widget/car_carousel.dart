import 'dart:async';
import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/car_service.dart';

class CarCarousel extends StatefulWidget {
  final CarService carService;

  CarCarousel({Key? key, CarService? carService})
      : carService = carService ?? CarService(),
        super(key: key);

  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  late PageController _pageController;
  late Timer _autoScrollTimer;
  final List<Car> _cars = [];
  bool _isLoading = false;
  bool _isUserScrolling = false;
  int _fakeStartIndex = 1000; // Large number to simulate infinite loop

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _fakeStartIndex, viewportFraction: 0.8);
    _loadMoreCars();
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreCars() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final newCars = await widget.carService.getCars(page: 1, limit: 10);
      if (mounted) {
        setState(() {
          _cars.addAll(newCars);
          _startAutoScroll();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_isUserScrolling || _cars.isEmpty || !_pageController.hasClients) return;

      _pageController.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoScroll() {
    _isUserScrolling = true;
    _autoScrollTimer.cancel();
  }

  void _resumeAutoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      _isUserScrolling = false;
      _startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cars.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          const Text(
            "🚗 Featured Cars",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 280,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is UserScrollNotification) _stopAutoScroll();
                if (scrollNotification is ScrollEndNotification) _resumeAutoScroll();
                return true;
              },
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final car = _cars[index % _cars.length]; // Infinite looping
                  return _buildCarCard(car);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarCard(Car car) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              car.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 50, color: Colors.red);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Column(
                children: [
                  Text(
                    car.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      Text(
                        car.rating.toString(),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
