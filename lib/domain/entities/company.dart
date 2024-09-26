import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id;
  final String name;
  final int? assetCount;

  const Company({required this.id, required this.name, this.assetCount});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Company copyWith({
    String? id,
    String? name,
    int? assetCount,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      assetCount: assetCount ?? this.assetCount,
    );
  }

  @override
  List<Object?> get props => [id, name, assetCount];
}
