import 'package:expense/data/categories_list_data.dart';
import 'package:expense/models/category.dart';

class CategoriesList {
  static final CategoriesList _instance = CategoriesList._internal();
  CategoriesList._internal();
  factory CategoriesList() {
    return _instance;
  }

  getData() async {
    await CategoriesListData().getCategoriesList();
    return _categories;
  }

  final Map<String, Category> _categories = {};
  Map<String, Category> get categories => _categories;
  void getFromList(List<Category> list) {
    _categories.clear();
    for (Category element in list) {
      _categories[element.name] = element;
    }
  }

  void expandFromList(List<Category> list) {
    for (Category element in list) {
      _categories[element.name] = element;
    }
  }

  @override
  String toString() => 'CategoriesList(categories: $_categories)';
}
