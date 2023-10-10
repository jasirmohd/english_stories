import 'package:cloud_firestore/cloud_firestore.dart';

class VideoResponseModel {
  final String? id;
  final String title;
  final String description;
  final String videoUrl;
  final String imageUrl;

  VideoResponseModel({
    this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.imageUrl
  });

  factory VideoResponseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return VideoResponseModel(
        id: doc.id,
        title: data['title'],
        description: data['description'],
        videoUrl: data['video_url'],
        imageUrl: data['image_url']
    );
  }
}
