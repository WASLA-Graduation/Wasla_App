enum ReactionType { love, save }

enum TargetType { post, comment }

enum PostType {
  post,
  love,
  save;

  static String getTapName(int index) {
    final postType = PostType.values[index];
    switch (postType) {
      case PostType.post:
        return "posts";
      case PostType.love:
        return "likes";
      case PostType.save:
        return "saves";
    }
  }


static PostType formInt(int index){
  return PostType.values[index];
}
}
