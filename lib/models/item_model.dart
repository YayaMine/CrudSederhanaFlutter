class Item {
  final int? id;
  final String name;
  final String price;
  final int quantity;
  final String sellingPrice;
  final String? imagePath;
  final String? date;
  final String? tanggalMasuk;
  final DateTime? createdAt;
  final DateTime? updateAt;

  Item({
    this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.sellingPrice,
    this.imagePath,
    this.date,
    this.tanggalMasuk,
    this.createdAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'sellingPrice': sellingPrice,
      'imagePath': imagePath,
      'date': date,
      'tanggalMasuk': tanggalMasuk,
      'createdAt': createdAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      sellingPrice: map['sellingPrice'],
      imagePath: map['imagePath'],
      date: map['date'],
      tanggalMasuk: map['tanggalMasuk'],
      createdAt:
          map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
      updateAt:
          map['updateAt'] != null ? DateTime.tryParse(map['updateAt']) : null,
    );
  }

  Item copyWith({
    int? id,
    String? name,
    String? price,
    int? quantity,
    String? sellingPrice,
    String? imagePath,
    String? date,
    String? tanggalMasuk,
    DateTime? createdAt,
    DateTime? updateAt,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
      tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, price: $price, quantity: $quantity, sellingPrice: $sellingPrice, imagePath: $imagePath, date: $date, tanggalMasuk: $tanggalMasuk, createdAt: $createdAt, updateAt: $updateAt}';
  }
}
