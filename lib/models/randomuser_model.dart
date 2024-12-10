import 'dart:convert';

class RandomuserListModel {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<Data>? data;

  RandomuserListModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
  });

  // Ubah: Input `String` ke `fromJson`
  factory RandomuserListModel.fromJson(String str) =>
      RandomuserListModel.fromMap(json.decode(str));

  // Tetap: `toJson` untuk serialisasi ke String
  String toJson() => json.encode(toMap());

  // Tetap: `fromMap` untuk parsing dari Map
  factory RandomuserListModel.fromMap(Map<String, dynamic> json) =>
      RandomuserListModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"]!.map((x) => Data.fromMap(x))),
      );

  // Tetap: `toMap` untuk konversi ke Map
  Map<String, dynamic> toMap() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Data {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  Data({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  // Properti getter untuk nama lengkap
  String get fullName {
    final first = firstName ?? '';
    final last = lastName ?? '';
    return '$first $last'.trim();
  }

  // Ubah: Input `String` ke `fromJson`
  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  // Tetap: `toJson` untuk serialisasi ke String
  String toJson() => json.encode(toMap());

  // Tetap: `fromMap` untuk parsing dari Map
  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  // Tetap: `toMap` untuk konversi ke Map
  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
