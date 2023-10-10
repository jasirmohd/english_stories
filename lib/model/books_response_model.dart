import 'package:cloud_firestore/cloud_firestore.dart';

class BookResponseModel {
  final String? id;
  final String title;
  final String description;
  final double rating;
  final String imageUrl;
  final String productUrl;

  BookResponseModel({
    this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.productUrl,
  });

  factory BookResponseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return BookResponseModel(
        id: doc.id,
        title: data['title'],
        description: data['description'],
        rating: data['rating'],
        imageUrl: data['image_url'],
        productUrl: data['product_url']
    );
  }
}