// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileModelAdapter extends TypeAdapter<UserProfileModel> {
  @override
  final int typeId = 0;

  @override
  UserProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileModel(
      email: fields[0] as String,
      username: fields[1] as String,
      followerCount: fields[2] as int,
      followingCount: fields[3] as int,
      relationship: fields[4] as RelationshipModel,
      userInfo: fields[5] as UserInfoModel,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.followerCount)
      ..writeByte(3)
      ..write(obj.followingCount)
      ..writeByte(4)
      ..write(obj.relationship)
      ..writeByte(5)
      ..write(obj.userInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RelationshipModelAdapter extends TypeAdapter<RelationshipModel> {
  @override
  final int typeId = 1;

  @override
  RelationshipModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RelationshipModel(
      isFriend: fields[0] as bool,
      isFriendRequest: fields[1] as bool,
      isFollowing: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, RelationshipModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isFriend)
      ..writeByte(1)
      ..write(obj.isFriendRequest)
      ..writeByte(2)
      ..write(obj.isFollowing);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RelationshipModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserInfoModelAdapter extends TypeAdapter<UserInfoModel> {
  @override
  final int typeId = 2;

  @override
  UserInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfoModel(
      userId: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      birthDate: fields[3] as DateTime,
      gender: fields[4] as int,
      address: fields[5] as String,
      phoneNumber: fields[6] as String,
      profilePictureUrl: fields[7] as String,
      profileBackgroundPictureUrl: fields[8] as String,
      bio: fields[9] as String,
      id: fields[10] as String,
      createdAt: fields[11] as DateTime,
      createdBy: fields[12] as String?,
      lastModified: fields[13] as DateTime,
      lastModifiedBy: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfoModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.birthDate)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.profilePictureUrl)
      ..writeByte(8)
      ..write(obj.profileBackgroundPictureUrl)
      ..writeByte(9)
      ..write(obj.bio)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.createdBy)
      ..writeByte(13)
      ..write(obj.lastModified)
      ..writeByte(14)
      ..write(obj.lastModifiedBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
