import 'package:equatable/equatable.dart';

class ShelfItem extends Equatable {
  final String? kind;
  final int? id;
  final String? title;
  final String? access;
  final DateTime? updated;
  final DateTime? created;
  final int? volumeCount;
  final DateTime? volumesLastUpdated;

  const ShelfItem({
    this.kind,
    this.id,
    this.title,
    this.access,
    this.updated,
    this.created,
    this.volumeCount,
    this.volumesLastUpdated,
  });

  factory ShelfItem.fromJson(Map<String, dynamic> json) => ShelfItem(
    kind: json['kind'] as String?,
    id: json['id'] as int?,
    title: json['title'] as String?,
    access: json['access'] as String?,
    updated: json['updated'] == null
        ? null
        : DateTime.parse(json['updated'] as String),
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    volumeCount: json['volumeCount'] as int?,
    volumesLastUpdated: json['volumesLastUpdated'] == null
        ? null
        : DateTime.parse(json['volumesLastUpdated'] as String),
  );

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'id': id,
    'title': title,
    'access': access,
    'updated': updated?.toIso8601String(),
    'created': created?.toIso8601String(),
    'volumeCount': volumeCount,
    'volumesLastUpdated': volumesLastUpdated?.toIso8601String(),
  };

  @override
  List<Object?> get props {
    return [
      kind,
      id,
      title,
      access,
      updated,
      created,
      volumeCount,
      volumesLastUpdated,
    ];
  }
}
