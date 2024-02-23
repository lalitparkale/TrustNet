//create a static class to hold the search text
class SearchModel {
  static String _searchText = '';

  static getSearchText() => _searchText;

  set searchText(String value) {
    _searchText = value;
  }
}
