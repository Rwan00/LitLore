import 'package:equatable/equatable.dart';

import 'access_info.dart';
import 'layer_info.dart';
import 'sale_info.dart';
import 'volume_info.dart';

class BookModel extends Equatable {
  final String? kind;
  final String id;
  final String? etag;
  final String? selfLink;
  final VolumeInfo volumeInfo;
  final LayerInfo? layerInfo;
  final SaleInfo? saleInfo;
  final AccessInfo? accessInfo;

  const BookModel({
    this.kind,
    required this.id,
    this.etag,
    this.selfLink,
    required this.volumeInfo,
    this.layerInfo,
    this.saleInfo,
    this.accessInfo,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        kind: json['kind'] as String?,
        id: json['id'] as String,
        etag: json['etag'] as String?,
        selfLink: json['selfLink'] as String?,
        volumeInfo: VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
        layerInfo: json['layerInfo'] == null
            ? null
            : LayerInfo.fromJson(json['layerInfo'] as Map<String, dynamic>),
        saleInfo: json['saleInfo'] == null
            ? null
            : SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
        accessInfo: json['accessInfo'] == null
            ? null
            : AccessInfo.fromJson(json['accessInfo'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'id': id,
        'etag': etag,
        'selfLink': selfLink,
        'volumeInfo': volumeInfo.toJson(),
        'layerInfo': layerInfo?.toJson(),
        'saleInfo': saleInfo?.toJson(),
        'accessInfo': accessInfo?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      kind,
      id,
      etag,
      selfLink,
      volumeInfo,
      layerInfo,
      saleInfo,
      accessInfo,
    ];
  }
}
