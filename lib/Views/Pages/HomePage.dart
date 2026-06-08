import 'package:my_app/Entities/Product.dart';
import 'package:my_app/ViewModel/ProductService.dart';
import 'package:my_app/Views/Pages/AboutPage.dart';
import 'package:my_app/Views/Widgets/ProductList.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Views/Widgets/ButtonBar.dart';
import 'package:my_app/Views/Widgets/Product_Widget.dart';

class Homepage1 extends StatelessWidget {
  const Homepage1({super.key});
  void AboutOnPress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => AboutOnPress(context),
          icon: const Icon(Icons.account_box_outlined),
        ),
      ),
      body: ProductListWidget(),
      bottomNavigationBar: const Buttonbar(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ProductService _productService = ProductService();
  late List<Product> products;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    products = _productService.getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Center(child: Text("Home Page")),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
            icon: const Icon(Icons.account_box_outlined),
          ),
        ],
      ),
      body: [
        ProductListReponsive(products: products),
        const Center(child: Text("Detail product (Please select a product from the list)")),
        const Center(child: Text("About Page")),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.details), label: "Detail"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: "About",
          ),
        ],
      ),
    );
  }
}
