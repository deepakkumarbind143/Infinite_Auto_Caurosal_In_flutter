import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/car.dart';

class CarService {
  // Flag to determine if we're using mock data or real API
  final bool useMockData;
  final String apiUrl;

  CarService({
    this.useMockData = true,
    this.apiUrl = 'https://api.example.com/cars',
  });

  // Get cars with pagination
  Future<List<Car>> getCars({int page = 1, int limit = 10}) async {
    if (useMockData) {
      return _getMockCars(page, limit);
    } else {
      return _getApiCars(page, limit);
    }
  }

  // Mock implementation that simulates API pagination
  Future<List<Car>> _getMockCars(int page, int limit) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Load mock data from assets
    final String response = await rootBundle.loadString('assets/mock_cars.json');
    final data = await json.decode(response) as List;

    // Convert to list of Car objects
    List<Car> allCars = data.map((item) => Car.fromJson(item)).toList();

    // Calculate pagination
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    // If we've reached the end of our data, loop back to the beginning to simulate infinite data
    if (startIndex >= allCars.length) {
      final adjustedStart = startIndex % allCars.length;
      final adjustedEnd = adjustedStart + limit > allCars.length
          ? allCars.length
          : adjustedStart + limit;
      return allCars.sublist(adjustedStart, adjustedEnd);
    }

    final actualEndIndex = endIndex > allCars.length ? allCars.length : endIndex;
    return allCars.sublist(startIndex, actualEndIndex);
  }

  // Real API implementation
  Future<List<Car>> _getApiCars(int page, int limit) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl?page=$page&limit=$limit'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((item) => Car.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load cars: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load cars: $e');
    }
  }

  // Get a list of predefined gradient colors for car frames
  List<Map<String, dynamic>> getCarFrameGradients() {
    return [
      {
        'begin': 0xFFE0F7FA,
        'end': 0xFFB2EBF2,
      },
      {
        'begin': 0xFFF3E5F5,
        'end': 0xFFE1BEE7,
      },
      {
        'begin': 0xFFFFF3E0,
        'end': 0xFFFFE0B2,
      },
      {
        'begin': 0xFFE8F5E9,
        'end': 0xFFC8E6C9,
      },
      {
        'begin': 0xFFE3F2FD,
        'end': 0xFFBBDEFB,
      },
    ];
  }
}
