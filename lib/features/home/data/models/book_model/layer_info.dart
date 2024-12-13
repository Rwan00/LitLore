import 'package:equatable/equatable.dart';

import 'layer.dart';

class LayerInfo extends Equatable {
  final List<Layer>? layers;

  const LayerInfo({this.layers});

  factory LayerInfo.fromJson(Map<String, dynamic> json) => LayerInfo(
        layers: (json['layers'] as List<dynamic>?)
            ?.map((e) => Layer.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'layers': layers?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [layers];
}
