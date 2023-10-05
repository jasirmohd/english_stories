import 'package:english_stories/resources/app_assets.dart';
import 'package:flutter/services.dart';

class StoryConfig{

  String getStoryJson(String category){
    switch(category){
      case "Akbar Birbal Stories":
        return AppAssets.akbarBirbalJson;
      case "Tenali Rama Stories":
        return AppAssets.tenaliRamaJson;
      case "Panchatantra Stories":
        return AppAssets.panchatantraJson;
      case "Arabian Nights Stories":
        return AppAssets.arabianNightsJson;
      case "Animal Stories":
        return AppAssets.animalJson;
      case "Bedtime Stories":
        return AppAssets.bedtimeJson;
      case "Classic Stories":
        return AppAssets.classicJson;
      case "Comical Stories":
        return AppAssets.comicalJson;
      case "Education Stories":
        return AppAssets.educationJson;
      case "Fables Stories":
        return AppAssets.fablesJson;
      case "Family Stories":
        return AppAssets.familyJson;
      case "Funny Stories":
        return AppAssets.funnyJson;
      case "General Stories":
        return AppAssets.generalJson;
      case "Humorous Stories":
        return AppAssets.humorousJson;
      case "Inspirational Stories":
        return AppAssets.inspirationalJson;
      case "Kid Stories":
        return AppAssets.kidJson;
      case "Life Stories":
        return AppAssets.lifeJson;
      case "Long Stories":
        return AppAssets.longJson;
      case "Love Stories":
        return AppAssets.loveJson;
      case "Moral Stories":
        return AppAssets.moralJson;
      case "Motivational Stories":
        return AppAssets.motivationalJson;
      case "Other Stories":
        return AppAssets.otherJson;
      case "Short Stories":
        return AppAssets.shortJson;
      case "Student Stories":
        return AppAssets.studentJson;
      default:
        return '';
    }
  }

  Future<String> getStoryList(String category) async {
    String fileName = getStoryJson(category);
    String storyJson = await rootBundle.loadString(fileName);
    return storyJson;
  }
}