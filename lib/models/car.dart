class Car {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final String color;
  final double rating;

  Car({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.color,
    required this.rating,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'color': color,
      'rating': rating,
    };
  }
}
