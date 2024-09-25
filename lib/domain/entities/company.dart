import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id;
  final String name;
  final int? assets;

  const Company({required this.id, required this.name, this.assets});

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
    int? assets,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      assets: assets ?? this.assets,
    );
  }

  @override
  List<Object?> get props => [id, name, assets];
}
