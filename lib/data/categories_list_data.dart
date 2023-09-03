import 'package:expense/models/categories_list.dart';
import 'package:expense/models/category.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoriesListData {
  CategoriesList? _categoriesList;
  final List<Category> _initCategoriesList = [
    Category(name: "Food", icon: Icons.food_bank),
    Category(name: "Cafe", icon: Icons.coffee),
    Category(name: "Entertainment", icon: Icons.games)
  ];

  static final CategoriesListData _instance = CategoriesListData._internal();
  CategoriesListData._internal();
  factory CategoriesListData() {
    return _instance;
  }

  initCategoriesList() async {
    var box = await Hive.openBox<Category>('categories');
    if (_categoriesList == null) {
      _categoriesList = CategoriesList()..expandFromList(_initCategoriesList);
      box.putAll(_categoriesList!.categories);
    } else {
      _getDataFromOpendBox(box);
    }
  }

  _getDataFromOpendBox(Box<Category> box) {
    final data = box.values.toList();
    _categoriesList = CategoriesList()..getFromList(data);
  }

  getCategoriesList() async {
    var box = await Hive.openBox<Category>('categories');
    _getDataFromOpendBox(box);
  }
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 0; // A unique identifier for this adapter

  @override
  Category read(BinaryReader reader) {
    return Category.fromMap(Map<String, dynamic>.from(reader.readMap()));
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.writeMap(obj.toMap());
  }
}
