class ChatUserInfo {
  final String id;
  final String name;
  final String profileImage;
  final String? bio;
  final String phone;
  bool isOnline;
  DateTime lastSeen;

  ChatUserInfo({
    required this.isOnline,
    required this.lastSeen,
    required this.id,
    required this.name,
    required this.profileImage,
    required this.bio,
    required this.phone,
  });

  factory ChatUserInfo.fromJson(Map<String, dynamic> json) {
    return ChatUserInfo(
      isOnline: json['isOnline'] ?? false,
      lastSeen: json['lastSeen'] != null
          ? DateTime.parse(json['lastSeen'])
          : DateTime.now(),
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profileImage'] ?? '',
      bio: json['bio'], // nullable
      phone: json['phone'] ?? '',
    );
  }
}
