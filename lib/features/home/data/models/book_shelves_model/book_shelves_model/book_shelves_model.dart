import 'package:equatable/equatable.dart';

import 'item.dart';

class BookShelvesModel extends Equatable {
  final String? kind;
  final List<ShelfItem>? items;

  const BookShelvesModel({this.kind, this.items});

  factory BookShelvesModel.fromJson(Map<String, dynamic> json) {
    return BookShelvesModel(
      kind: json['kind'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ShelfItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'items': items?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [kind, items];
}
