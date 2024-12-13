import 'package:equatable/equatable.dart';

class Layer extends Equatable {
  final String? layerId;
  final String? volumeAnnotationsVersion;

  const Layer({this.layerId, this.volumeAnnotationsVersion});

  factory Layer.fromJson(Map<String, dynamic> json) => Layer(
        layerId: json['layerId'] as String?,
        volumeAnnotationsVersion: json['volumeAnnotationsVersion'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'layerId': layerId,
        'volumeAnnotationsVersion': volumeAnnotationsVersion,
      };

  @override
  List<Object?> get props => [layerId, volumeAnnotationsVersion];
}
