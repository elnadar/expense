import 'package:flutter/material.dart';

abstract final class IconsMap {
  static getIconFromString(String iconName) => _iconsMapStringToIcon[iconName];
  static final Map<String, IconData> _iconsMapStringToIcon = {
    Icons.food_bank.toString(): Icons.food_bank,
    Icons.coffee.toString(): Icons.coffee,
    Icons.games.toString(): Icons.games,
  };
}
