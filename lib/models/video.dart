import 'package:academic_app/models/user.dart';

class Video {
  final User user;
  final String image;
  final String url;

  const Video({
    required this.user,
    required this.image,
    required this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      user: User.fromJson(json['user']),
      image: json['image'],
      url: json['video_files'][0]['link'],
    );
  }
}
