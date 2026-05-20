class Product {
  String id;
  String name;
  String image;
  double price;

  // Constructor
  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  // Factory constructor: map Json -> Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }

  // Convert Product -> Json
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'price': price};
  }

  @override
  String toString() {
    return 'ID: $id | Name: $name | Price: $price';
  }
}

class ProductManager {
  // Danh sách tĩnh mặc định
  static List<Product> products = [
    Product(id: "P01", name: "Laptop", image: "laptop.png", price: 1000),
    Product(id: "P02", name: "Mouse", image: "mouse.png", price: 50),
    Product(id: "P03", name: "Keyboard", image: "keyboard.png", price: 80),
  ];

  // Add Product
  static void add(Product product) {
    products.add(product);
  }

  // Edit Product
  static void edit(Product updatedProduct) {
    int index = products.indexWhere((p) => p.id == updatedProduct.id);

    if (index != -1) {
      products[index] = updatedProduct;
    }
  }

  // Search by name
  static List<Product> searchByName(String keyword) {
    return products
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  // Search by price > value
  static List<Product> searchByPrice(double minPrice) {
    return products.where((p) => p.price >= minPrice).toList();
  }

  // Find by ID
  static Product? find(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // Increase price by 10% using declarative map
  static void increasePrice() {
    products = products.map((p) {
      return Product(
        id: p.id,
        name: p.name,
        image: p.image,
        price: p.price * 1.1,
      );
    }).toList();
  }

  // Display all products
  static void display() {
    for (var p in products) {
      print(p);
    }
  }
}

void main() {
  print("=== Danh sách ban đầu ===");
  ProductManager.display();

  // Add
  ProductManager.add(
    Product(id: "P04", name: "Monitor", image: "monitor.png", price: 300),
  );

  print("\n=== Sau khi thêm ===");
  ProductManager.display();

  // Edit
  ProductManager.edit(
    Product(
      id: "P02",
      name: "Gaming Mouse",
      image: "gaming_mouse.png",
      price: 70,
    ),
  );

  print("\n=== Sau khi sửa ===");
  ProductManager.display();

  // Search
  print("\n=== Search Name: mouse ===");
  var result = ProductManager.searchByName("mouse");
  result.forEach(print);

  // Find
  print("\n=== Find Product P01 ===");
  print(ProductManager.find("P01"));

  // Increase Price
  ProductManager.increasePrice();

  print("\n=== Sau khi tăng giá 10% ===");
  ProductManager.display();

  // JSON -> Product
  Map<String, dynamic> jsonData = {
    "id": "P05",
    "name": "Phone",
    "image": "phone.png",
    "price": 500,
  };

  Product phone = Product.fromJson(jsonData);

  print("\n=== Product từ JSON ===");
  print(phone);
}
