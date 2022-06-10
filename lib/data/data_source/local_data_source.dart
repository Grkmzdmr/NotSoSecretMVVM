import 'package:not_so_secret/data/network/error_handler.dart';
import 'package:not_so_secret/data/responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 Minute

abstract class LocalDataSource {
  Future<HomeDataResponse> getHome();
  Future<void> saveHomeToCache(HomeDataResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeDataResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
      //return the response from cache
    } else {
      //return error that cache is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeDataResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isCacheValid = currentTimeInMillis - expirationTime < cacheTime;
    return isCacheValid;
  }
}
