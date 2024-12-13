import 'package:equatable/equatable.dart';

class Dimensions extends Equatable {
  final String? height;

  const Dimensions({this.height});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        height: json['height'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'height': height,
      };

  @override
  List<Object?> get props => [height];
}
