import 'package:my_app/Entities/Product.dart';
import 'package:my_app/Views/Widgets/ProductWidget.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) =>
          ProductWidgetStateFull(product: products[index]),
    );
  }
}

class ProductListReponsive extends StatelessWidget {
  final List<Product> products;
  const ProductListReponsive({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GridView.count(
        crossAxisCount: constraints.maxWidth <= 450 ? 1 : 2,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          for (var product in products)
            ProductWidgetStateFull(product: product),
        ],
      ),
    );
  }
}
