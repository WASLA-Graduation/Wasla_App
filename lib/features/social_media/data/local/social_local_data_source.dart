import 'package:wasla/core/database/cache/hive_service.dart';
import 'package:wasla/features/social_media/data/models/social_post_model.dart';

import '../../../../core/utils/app_strings.dart';

abstract class SocialLocalDataSource {
  Future<void> cachePosts(List<SocialPostModel> posts);
  Future<List<SocialPostModel>> getCachedPosts();
}

class SocialLocalDataSourceImpl implements SocialLocalDataSource {
  SocialLocalDataSourceImpl();

  @override
  Future<void> cachePosts(List<SocialPostModel> posts) async {
    await HiveService.putAll(
      boxName: AppStrings.socialBox,
      map: {
        AppStrings.postsList: posts.map((p) => p.toJson()).toList(),
        AppStrings.postsTimeStamp: DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  @override
  Future<List<SocialPostModel>> getCachedPosts() {
    final int? timestamp = HiveService.get(
      boxName: AppStrings.socialBox,
      key: AppStrings.postsTimeStamp,
      defaultValue: null,
    );

    if (timestamp == null) return Future.value([]);

    final DateTime savedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (DateTime.now().difference(savedAt).inHours >= 24) {
      HiveService.deleteAll(
        boxName: AppStrings.socialBox,
        keys: [AppStrings.postsList, AppStrings.postsTimeStamp],
      );
      return Future.value([]);
    }

    return Future.value(
      List.from(
            HiveService.get(
              boxName: AppStrings.socialBox,
              key: AppStrings.postsList,
              defaultValue: [],
            ),
          )
          .map((e) => SocialPostModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}
