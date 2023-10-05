import 'package:cloud_firestore/cloud_firestore.dart';

class OneDayStoryResponseModel {
  final String? id;
  final String date;
  final String title;
  final String category;
  final String body;
  final String imageUrl;

  OneDayStoryResponseModel({
    this.id,
    required this.date,
    required this.title,
    required this.category,
    required this.body,
    required this.imageUrl
  });

  factory OneDayStoryResponseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return OneDayStoryResponseModel(
        id: doc.id,
        date: data['date'],
        title: data['title'],
        category: data['category'],
        body: data['body'],
        imageUrl: data['image_url']
    );
  }
}
