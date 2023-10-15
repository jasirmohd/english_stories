// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryDBModelAdapter extends TypeAdapter<StoryDBModel> {
  @override
  final int typeId = 1;

  @override
  StoryDBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryDBModel(
      id: fields[0] as int?,
      category: fields[1] as String?,
      title: fields[2] as String?,
      body: fields[3] as String?,
      isFavourite: fields[4] as bool?,
      isBookmarked: fields[5] as bool?,
    )
      ..isUnRead = fields[6] as bool?
      ..imageUrl = fields[7] as String?
      ..storyImageUrl = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, StoryDBModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.isFavourite)
      ..writeByte(5)
      ..write(obj.isBookmarked)
      ..writeByte(6)
      ..write(obj.isUnRead)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.storyImageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryDBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
