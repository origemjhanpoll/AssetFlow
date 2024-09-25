import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String? parentId;

  const Location({required this.id, required this.name, this.parentId});

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
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  @override
  List<Object?> get props => [id, name, parentId];
}
