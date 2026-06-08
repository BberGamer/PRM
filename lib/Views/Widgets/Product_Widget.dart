import 'package:my_app/ViewModel/ProductService.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Entities/Product.dart';
import 'package:my_app/Views/Pages/ProductDetailPage.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget({super.key});
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    final products = productService.getAllProduct();
    return ReponsiveProudct(products: products);
  }
}

class ReponsiveProudct extends StatelessWidget {
  final List<Product> products;
  const ReponsiveProudct({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width < 450 ? 1 : 2,
      children: products
          .map((product) => ProductWidget(product: product))
          .toList(),
    );
  }
}

class OneColumnProduct extends StatelessWidget {
  final List<Product> products;
  const OneColumnProduct({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var product in products) ProductWidget(product: product),
      ],
    );
  }
}

class ProductWidget extends StatefulWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ProductContainer(product: widget.product),
    );
  }
}

class ProductContainer extends StatefulWidget {
  final Product product;
  const ProductContainer({super.key, required this.product});

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  int _selectSort = 0;
  int _count = 456;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: widget.product),
              ),
            );
          },
          child: Container(
            width: constraints.maxWidth <= 450
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width / 2,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Top controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<int>(
                      value: _selectSort,
                      items: const [
                        DropdownMenuItem(value: 0, child: Text("A-Z")),
                        DropdownMenuItem(value: 1, child: Text("Z-A")),
                        DropdownMenuItem(value: 2, child: Text("Low to High")),
                        DropdownMenuItem(value: 3, child: Text("High to Low")),
                      ],
                      onChanged: (value) => setState(() {
                        _selectSort = value!;
                      }),
                    ),
                    const Icon(Icons.info_outline, color: Colors.blue),
                  ],
                ),

                // Product Image Section
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.asset(
                            widget.product.image ?? 'assets/images/dog.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton.small(
                            heroTag: "btn_${widget.product.id}",
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Added ${widget.product.name} to cart!"),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Icon(Icons.shopping_cart),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Product details row (name, price, star rating count increment)
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Price: ${widget.product.price}\$",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _count++;
                          });
                        },
                        icon: const Icon(
                          Icons.plus_one,
                          color: Colors.amber,
                        ),
                      ),
                      Text("$_count"),
                    ],
                  ),
                ),

                // Five stars list
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                    ),
                  ),
                ),

                // Description Card
                Expanded(
                  flex: 3,
                  child: Card(
                    color: Colors.grey[50],
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: SingleChildScrollView(
                        child: Text(
                          "This is a premium product with excellent build quality and specs. It is highly rated by customers. Tap the item to see full specifications and reviews.",
                          style: TextStyle(fontSize: 11),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
