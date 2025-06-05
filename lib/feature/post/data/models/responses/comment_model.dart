// // class CommentModel {
// //   final String id;
// //   final String userId;
// //   final String postId;
// //   final String? parentCommentId;
// //   final String content;
// //   final String mediaUrl;
// //   final int votes;
// //   final int replyCount;
// //   final dynamic score;
// //   final UserModel? user;
// //   final dynamic userVoteType;
// //   final bool isDeleted;
// //   final PostModel? post;
// //   final String? parentComment;
// //   final DateTime createdAt;
// //   final String? createdBy;
// //   final DateTime lastModified;
// //   final String? lastModifiedBy;
// //   final int? votesCount;
// //   final List<dynamic>? commentVotes;
// //   final int? votesCont;
//
// //   CommentModel({
// //     required this.id,
// //     required this.userId,
// //     required this.postId,
// //     this.parentCommentId,
// //     required this.content,
// //     required this.mediaUrl,
// //     required this.votes,
// //     required this.replyCount,
// //     this.score,
// //     this.user,
// //     this.userVoteType,
// //     required this.isDeleted,
// //     this.post,
// //     this.parentComment,
// //     required this.createdAt,
// //     this.createdBy,
// //     required this.lastModified,
// //     this.lastModifiedBy,
// //     this.votesCount,
// //     this.commentVotes,
// //     this.votesCont,
// //   });
//
// //   factory CommentModel.fromCreateJson(Map<String, dynamic> json) {
// //     return CommentModel(
// //       id: json['id'] ?? '',
// //       userId: json['userId'] ?? '',
// //       postId: json['postId'] ?? '',
// //       post: json['post'] != null ? PostModel.fromJson(json['post']) : null,
// //       parentCommentId: json['parentCommentId'] ?? '',
// //       parentComment: json['parentComment'] ?? '',
// //       content: json['content'] ?? '',
// //       mediaUrl: json['mediaUrl'] ?? '',
// //       votesCont: json['votesCont'] ?? 0,
// //       commentVotes: json['commentVotes'] ?? [],
// //       replyCount: json['replyCount'] ?? 0,
// //       isDeleted: json['isDeleted'] ?? false,
// //       createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
// //       createdBy: json['createdBy'] ?? '',
// //       lastModified:
// //           DateTime.tryParse(json['lastModified'] ?? '') ?? DateTime.now(),
// //       lastModifiedBy: json['lastModifiedBy'] ?? '',
// //     );
// //   }
//
// //   factory CommentModel.fromListJson(Map<String, dynamic> json) {
// //     return CommentModel(
// //       id: json['id'] ?? '',
// //       userId: json['userId'] ?? '',
// //       postId: json['postId'] ?? '',
// //       parentCommentId: json['parentCommentId'],
// //       content: json['content'] ?? '',
// //       mediaUrl: json['mediaUrl'] ?? '',
// //       votes: json['votes'] ?? 0,
// //       replyCount: json['replyCount'] ?? 0,
// //       score: json['score'],
// //       user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
// //       userVoteType: json['userVoteType'],
// //       isDeleted: json['isDeleted'] ?? false,
// //     );
// //   }
// // }
//
// import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
//
// class CommentModel {
//   final String id;
//   final String userId;
//   final String postId;
//   final String? parentCommentId;
//   final String content;
//   final String mediaUrl;
//   final int votes;
//   final int replyCount;
//   final dynamic score;
//   final UserModel? user;
//   final dynamic userVoteType;
//   final bool isDeleted;
//   final PostModel? post;
//   final String? parentComment;
//   final DateTime createdAt;
//   final String? createdBy;
//   final DateTime lastModified;
//   final String? lastModifiedBy;
//   final int? votesCount;
//   final List<dynamic>? commentVotes;
//   final int? votesCont;
//
//   CommentModel({
//     required this.id,
//     required this.userId,
//     required this.postId,
//     this.parentCommentId,
//     required this.content,
//     required this.mediaUrl,
//     required this.votes,
//     required this.replyCount,
//     this.score,
//     this.user,
//     this.userVoteType,
//     required this.isDeleted,
//     this.post,
//     this.parentComment,
//     required this.createdAt,
//     this.createdBy,
//     required this.lastModified,
//     this.lastModifiedBy,
//     this.votesCount,
//     this.commentVotes,
//     this.votesCont,
//   });
//
//   factory CommentModel.fromJson(Map<String, dynamic> json) {
//     return CommentModel(
//       id: json['id'] ?? '',
//       userId: json['userId'] ?? '',
//       postId: json['postId'] ?? '',
//       parentCommentId: json['parentCommentId'],
//       content: json['content'] ?? '',
//       mediaUrl: json['mediaUrl'] ?? '',
//       votes: json['votes'] ?? json['votesCont'] ?? 0,
//       replyCount: json['replyCount'] ?? 0,
//       score: json['score'],
//       user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
//       userVoteType: json['userVoteType'],
//       isDeleted: json['isDeleted'] ?? false,
//       post: json['post'] != null ? PostModel.fromJson(json['post']) : null,
//       parentComment: json['parentComment'],
//       createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//       createdBy: json['createdBy'],
//       lastModified:
//           DateTime.tryParse(json['lastModified'] ?? '') ?? DateTime.now(),
//       lastModifiedBy: json['lastModifiedBy'],
//       votesCount: json['votesCount'],
//       commentVotes: json['commentVotes'],
//       votesCont: json['votesCont'],
//     );
//   }
//
//   CommentEntity toEntity() {
//     return CommentEntity(
//       id: id,
//       userId: userId,
//       postId: postId,
//       parentCommentId: parentCommentId,
//       content: content,
//       mediaUrl: mediaUrl,
//       votes: votes,
//       replyCount: replyCount,
//       isDeleted: isDeleted,
//       createdAt: createdAt,
//       lastModified: lastModified,
//       user: user?.toEntity(),
//       post: post?.toEntity(),
//     );
//   }
// }
//
// class UserModel {
//   final String id;
//   final bool isFriend;
//   final bool isFollowing;
//   final String email;
//   final String username;
//   final String firstName;
//   final String lastName;
//   final DateTime? birthDate;
//   final int gender;
//   final String address;
//   final String phoneNumber;
//   final String profilePictureUrl;
//   final String? bio;
//
//   UserModel({
//     required this.id,
//     required this.isFriend,
//     required this.isFollowing,
//     required this.email,
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     this.birthDate,
//     required this.gender,
//     required this.address,
//     required this.phoneNumber,
//     required this.profilePictureUrl,
//     this.bio,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json['id'] ?? '',
//         isFriend: json['isFriend'] ?? false,
//         isFollowing: json['isFollowing'] ?? false,
//         email: json['email'] ?? '',
//         username: json['username'] ?? '',
//         firstName: json['firstName'] ?? '',
//         lastName: json['lastName'] ?? '',
//         birthDate: json['birthDate'] != null
//             ? DateTime.tryParse(json['birthDate'])
//             : null,
//         gender: json['gender'] ?? 0,
//         address: json['address'] ?? '',
//         phoneNumber: json['phoneNumber'] ?? '',
//         profilePictureUrl: json['profilePictureUrl'] ?? '',
//         bio: json['bio'],
//       );
//
//   UserEntity toEntity() {
//     return UserEntity(
//       id: id,
//       isFriend: isFriend,
//       isFollowing: isFollowing,
//       email: email,
//       username: username,
//       firstName: firstName,
//       lastName: lastName,
//       birthDate: birthDate,
//       gender: gender,
//       address: address,
//       phoneNumber: phoneNumber,
//       profilePictureUrl: profilePictureUrl,
//       bio: bio,
//     );
//   }
// }
//
// class PostModel {
//   final String userId;
//   final String? groupId;
//   final String content;
//   final String mediaUrl;
//   final int privacy;
//   final bool isDeleted;
//   final int votesCount;
//   final List<dynamic> userVoteds;
//   final String? categoryId;
//   final dynamic category;
//   final bool isApproved;
//   final int commentsCount;
//   final dynamic score;
//   final String id;
//   final DateTime createdAt;
//   final String createdBy;
//   final DateTime lastModified;
//   final dynamic lastModifiedBy;
//
//   PostModel({
//     required this.userId,
//     this.groupId,
//     required this.content,
//     required this.mediaUrl,
//     required this.privacy,
//     required this.isDeleted,
//     required this.votesCount,
//     required this.userVoteds,
//     this.categoryId,
//     this.category,
//     required this.isApproved,
//     required this.commentsCount,
//     this.score,
//     required this.id,
//     required this.createdAt,
//     required this.createdBy,
//     required this.lastModified,
//     this.lastModifiedBy,
//   });
//
//   factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
//         userId: json['userId'] ?? '',
//         groupId: json['groupId'],
//         content: json['content'] ?? '',
//         mediaUrl: json['mediaUrl'] ?? '',
//         privacy: json['privacy'] ?? 0,
//         isDeleted: json['isDeleted'] ?? false,
//         votesCount: json['votesCount'] ?? 0,
//         userVoteds: json['userVoteds'] ?? [],
//         categoryId: json['categoryId'],
//         category: json['category'],
//         isApproved: json['isApproved'] ?? false,
//         commentsCount: json['commentsCount'] ?? 0,
//         score: json['score'],
//         id: json['id'] ?? '',
//         createdAt: DateTime.parse(json['createdAt']),
//         createdBy: json['createdBy'] ?? '',
//         lastModified: DateTime.parse(json['lastModified']),
//         lastModifiedBy: json['lastModifiedBy'],
//       );
//
//   PostEntity toEntity() {
//     return PostEntity(
//       userId: userId,
//       groupId: groupId,
//       content: content,
//       mediaUrl: mediaUrl,
//       privacy: privacy,
//       isDeleted: isDeleted,
//       votesCount: votesCount,
//       userVoteds: userVoteds,
//       categoryId: categoryId,
//       category: category,
//       isApproved: isApproved,
//       commentsCount: commentsCount,
//       score: score,
//       id: id,
//       createdAt: createdAt,
//       createdBy: createdBy,
//       lastModified: lastModified,
//       lastModifiedBy: lastModifiedBy,
//     );
//   }
// }

import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';

class CommentModel {
  final String id;
  final String userId;
  final String postId;
  final String? parentCommentId;
  final String? parentComment;
  final String content;
  final String mediaUrl;
  final int votes;
  final int voteCount;
  final int? score;
  final int replyCount;
  final List<String>? commentVotes;
  final int? userVoteType;
  final bool isDeleted;
  final String? createdBy;
  final DateTime? createdAt;
  final DateTime? lastModified;
  final String? lastModifiedBy;
  final UserModel? user;

  const CommentModel({
    required this.id,
    required this.userId,
    required this.postId,
    this.parentCommentId,
    this.parentComment,
    required this.content,
    required this.mediaUrl,
    required this.votes,
    required this.voteCount,
    this.score,
    required this.replyCount,
    this.commentVotes,
    this.userVoteType,
    required this.isDeleted,
    this.createdBy,
    this.createdAt,
    this.lastModified,
    this.lastModifiedBy,
    this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      postId: json['postId'] ?? '',
      parentCommentId: json['parentCommentId'],
      parentComment: json['parentComment'] ?? '',
      content: json['content'] ?? '',
      mediaUrl: json['mediaUrl'] ?? '',
      votes: json['votes'] ?? 0,
      voteCount: json['votes'] ?? json['voteCount'] ?? 0,
      score: json['score'],
      replyCount: json['replyCount'] ?? 0,
      commentVotes: (json['commentVotes'] as List?)?.map((e) => e.toString()).toList(),
      userVoteType: json['userVoteType'],
      isDeleted: json['isDeleted'] ?? false,
      createdBy: json['createdBy'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      lastModified: json['lastModified'] != null ? DateTime.tryParse(json['lastModified']) : null,
      lastModifiedBy: json['lastModifiedBy'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

class UserModel {
  final String id;
  final bool isFriend;
  final bool isFollowing;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final int gender;
  final String? address;
  final String phoneNumber;
  final String profilePictureUrl;
  final String bio;

  const UserModel({
    required this.id,
    required this.isFriend,
    required this.isFollowing,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      isFriend: json['isFriend'] ?? false,
      isFollowing: json['isFollowing'] ?? false,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'])
          : null,
      gender: json['gender'] ?? 0,
      address: json['address'],
      phoneNumber: json['phoneNumber'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      bio: json['bio'] ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      isFriend: isFriend,
      isFollowing: isFollowing,
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      gender: gender,
      address: address,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      bio: bio,
    );
  }
}