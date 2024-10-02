import 'package:asset_flow/domain/entities/asset.dart';
import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String? parentId;
  final List<Location>? subLocations;
  final List<Asset>? assets;

  const Location({
    required this.id,
    required this.name,
    this.parentId,
    this.subLocations,
    this.assets,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  Location copyWith({
    String? id,
    String? name,
    String? parentId,
    List<Location>? subLocations,
    List<Asset>? assets,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      subLocations: subLocations ?? this.subLocations,
      assets: assets ?? this.assets,
    );
  }

  @override
  List<Object?> get props => [id, name, parentId, subLocations, assets];
}
