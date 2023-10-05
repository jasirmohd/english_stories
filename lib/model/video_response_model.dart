import 'package:cloud_firestore/cloud_firestore.dart';

class VideoResponseModel {
  final String? id;
  final String date;
  final String title;
  final String category;
  final String videoUrl;
  final String imageUrl;

  VideoResponseModel({
    this.id,
    required this.date,
    required this.title,
    required this.category,
    required this.videoUrl,
    required this.imageUrl
  });

  factory VideoResponseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return VideoResponseModel(
        id: doc.id,
        date: data['date'],
        title: data['title'],
        category: data['category'],
        videoUrl: data['video_url'],
        imageUrl: data['image_url']
    );
  }
}
