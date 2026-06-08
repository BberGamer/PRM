import 'package:my_app/Entities/Product.dart';
import 'package:my_app/Repository/ProductDAO.dart';

class ProductService {
  List<Product>? products;
  ProductService() {
    ProductDAO productDAO = ProductDAO();
    products = productDAO.getAllProduct();
  }
  List<Product> getAllProduct() {
    return products!;
  }
}