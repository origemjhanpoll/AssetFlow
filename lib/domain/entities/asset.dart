import 'package:asset_flow/presentation/widgets/asset_widget.dart';
import 'package:equatable/equatable.dart';

class Asset extends Equatable {
  final String id;
  final String name;
  final String? gatewayId;
  final String? locationId;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final AssetType? type;
  final List<Asset>? elements;

  const Asset({
    required this.id,
    required this.name,
    this.gatewayId,
    this.locationId,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.type,
    this.elements,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gatewayId': gatewayId,
      'locationId': locationId,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
    };
  }

  Asset copyWith({
    String? id,
    String? name,
    String? locationId,
    String? parentId,
    String? sensorId,
    String? sensorType,
    String? status,
    AssetType? type,
    List<Asset>? elements,
  }) {
    return Asset(
      id: id ?? this.id,
      name: name ?? this.name,
      locationId: locationId ?? this.locationId,
      parentId: parentId ?? this.parentId,
      sensorId: sensorId ?? this.sensorId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      type: type ?? this.type,
      elements: elements ?? this.elements,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        locationId,
        parentId,
        sensorId,
        sensorType,
        status,
        type,
        elements,
      ];
}
