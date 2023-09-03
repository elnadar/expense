// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:expense/utils/icons.dart';
import 'package:flutter/material.dart';

import 'package:expense/utils/theme.dart';

class Category {
  final String name;
  final Color _color;
  final IconData? icon;

  Category({required this.name, Color? color, required this.icon})
      : _color = color ?? mainScheme.primary;

  Color get color => _color;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'color': _color.value,
      'icons': icon.toString(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] as String,
      color: Color(map['color'] as int),
      icon: map['icons'] != null ? IconsMap.icons[map['icons']] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(name: $name, _color: $_color, icons: $icon)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.name == name && other._color == _color && other.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ _color.hashCode ^ icon.hashCode;
}
