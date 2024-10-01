import 'package:aldi_test/view/dashboard/dashboard.page.dart';
import 'package:aldi_test/view/product/product.page.dart';
import 'package:aldi_test/view/sale/sale.page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find<NavigationController>();
  final current = 0.obs;
  final pages = <Map<String, dynamic>>[
    {
      'icon': Icons.dashboard_rounded,
      'title': 'Dashboard',
      "page": const DashboardPage(),
    },
    {
      'icon': Icons.shopping_bag_rounded,
      'title': 'Produk',
      "page": const ProductPage(),
    },
    {
      'icon': Icons.shopping_cart,
      'title': 'Penjualan',
      "page": const SalePage(),
    },
  ];

  Widget get page => pages[current.value]["page"];

  onNavChanged(int index) => current.value = index;
}
