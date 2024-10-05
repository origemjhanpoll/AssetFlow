import 'package:asset_flow/utils/types.dart';
import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String id;
  final String name;
  final String? gatewayId;
  final String? locationId;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final BranchType branchType;
  final List<Branch> branches;

  Branch({
    required this.id,
    required this.name,
    this.gatewayId,
    this.locationId,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    required this.branchType,
    List<Branch>? branches,
  }) : branches = branches ?? [];

  SensorType? get getSensorType {
    if (sensorType == 'energy') {
      return SensorType.energy;
    } else {
      return SensorType.vibration;
    }
  }

  StatusType? get getStatusType {
    if (status == 'alert') {
      return StatusType.alert;
    } else {
      return StatusType.operating;
    }
  }

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
      branchType: BranchType.root,
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

  Branch copyWith({
    String? id,
    String? name,
    String? locationId,
    String? parentId,
    String? sensorId,
    String? sensorType,
    String? status,
    BranchType? branchType,
    List<Branch>? branches,
  }) {
    return Branch(
      id: id ?? this.id,
      name: name ?? this.name,
      locationId: locationId ?? this.locationId,
      parentId: parentId ?? this.parentId,
      sensorId: sensorId ?? this.sensorId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      branchType: branchType ?? this.branchType,
      branches: branches ?? this.branches,
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
        branchType,
        branches,
      ];
}
