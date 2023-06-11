import 'package:travel_app_ytb/helpers/local_storage_helper.dart';

class SearchHistory {
  Future<void> saveSearchHistory(String searchItem) async {
    List<String>? searchHistory = await LocalStorageHelper.getValue("searchHistory") as List<String>?;
    if (searchHistory == null) {
      searchHistory = [searchItem];
    } else {
      searchHistory.insert(0, searchItem);
    }
    if (searchHistory.length > 10) {
      searchHistory = searchHistory.sublist(0, 10);
    }

    await LocalStorageHelper.setValue("searchHistory", searchHistory);
  }

  Future<List<String>> getSearchHistory() async {
    List<String>? searchHistory = LocalStorageHelper.getValue("searchHistory") as List<String>?;
    if (searchHistory == null) {
      return [];
    }
    return searchHistory;
  }

  Future<void> deleteAllSearchHistory() async {
    await LocalStorageHelper.deleteValue("searchHistory");
  }

  Future<void> deleteSearchItem(String searchItem) async {
    List<String>? searchHistory = await LocalStorageHelper.getValue("searchHistory") as List<String>?;
    if (searchHistory != null) {
      if (searchHistory.contains(searchItem) == true) {
        searchHistory.remove(searchItem);
      }
    }
    await LocalStorageHelper.setValue("searchHistory", searchHistory);
  }

}