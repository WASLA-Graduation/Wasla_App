import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';

Future<String?> getUserId() async {
  return await SecureStorageHelper.get(key: ApiKeys.userId);
}
