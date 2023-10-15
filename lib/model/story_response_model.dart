import 'package:cloud_firestore/cloud_firestore.dart';

class StoryResponseModel {
  final String? id;
  final String title;
  final String category;
  final String body;
  final String imageUrl;
  final String storyImageUrl;

  StoryResponseModel({
    this.id,
    required this.title,
    required this.category,
    required this.body,
    required this.imageUrl,
    required this.storyImageUrl,
  });

  factory StoryResponseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return StoryResponseModel(
        id: doc.id,
        title: data['title'],
        category: data['category'],
        body: data['body'],
        imageUrl: data['image_url'],
        storyImageUrl: data['story_image_url']
    );
  }
}