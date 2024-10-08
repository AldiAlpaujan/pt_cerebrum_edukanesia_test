import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/dashboard/dashboard.controller.dart';
import 'package:aldi_test/view/product/widget/app_product_card.dart';
import 'package:aldi_test/view/sale/sale.page.detail.dart';
import 'package:aldi_test/view/sale/widget/app_sale_card.dart';
import 'package:aldi_test/widget/app_loading.dart';
import 'package:aldi_test/widget/app_square_initial.dart';
import 'package:aldi_test/widget/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_icons/weather_icons.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => controller.getDataSummary(),
          child: ListView(
            children: [
              const SizedBox(height: AppTheme.padding),
              header(),
              weather(),
              saleSummary(),
              productSummary(),
              const SizedBox(height: AppTheme.padding),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppTheme.padding,
        right: 2,
        bottom: 30,
      ),
      child: Row(
        children: [
          AppSquareInitial(initial: user!.initial),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang ${user!.username}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  user!.email,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.capColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget weather() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Obx(
        () => summaryCard(
          title: "Ramalan Cuaca",
          onSeeAll: null,
          isLoading: controller.weatherLoading,
          notFound: controller.weathers.isEmpty,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16),
            child: Row(
              children: [
                ...controller.weathers.map(
                  (e) => Expanded(
                    child: Column(
                      children: [
                        Icon(_getIcon(e['code']), size: 40),
                        const SizedBox(height: 10),
                        Text(
                          e['id'] == 1 ? "Hari ini" : "Besok",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.capColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          e['weatherDescription'].toString().capitalize!,
                          style: const TextStyle(
                            color: AppTheme.titleColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${e['temperature']}°C",
                          style: const TextStyle(
                            color: AppTheme.titleColor,
                          ),
                        ),
                      ],
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

  IconData _getIcon(int condition) {
    if (condition < 300) {
      return WeatherIcons.thunderstorm;
    } else if (condition < 400) {
      return WeatherIcons.sprinkle;
    } else if (condition < 600) {
      return WeatherIcons.rain;
    } else if (condition < 700) {
      return WeatherIcons.snow;
    } else if (condition < 800) {
      return WeatherIcons.fog;
    } else if (condition == 800) {
      return WeatherIcons.day_sunny;
    } else if (condition == 801) {
      return WeatherIcons.day_cloudy;
    } else if (condition == 802) {
      return WeatherIcons.cloud;
    } else if (condition == 803 || condition == 804) {
      return WeatherIcons.cloudy;
    } else {
      return WeatherIcons
          .alien; // Ikon default untuk kondisi yang tidak dikenal
    }
  }

  Widget saleSummary() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Obx(
        () => summaryCard(
          title: "Penjualan Hari Ini",
          onSeeAll: controller.salePage,
          isLoading: controller.loading,
          notFound: controller.saleData.isEmpty,
          child: Column(
            children: controller
                .saleData()
                .map(
                  (e) => AppSaleCard(
                    sale: e,
                    onTap: SaleDetailPage.open,
                    isLast: e.id == controller.saleData().last.id,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget productSummary() {
    return Obx(
      () => summaryCard(
        title: "Produk terlaris",
        onSeeAll: null,
        isLoading: controller.loading,
        notFound: controller.productData.isEmpty,
        child: Column(
          children: controller
              .productData()
              .map(
                (e) => AppProductCard(
                  product: e,
                  onTap: (e) => Get.toNamed(Routes.productForm, arguments: e),
                  isLast: e.id == controller.saleData().last.id,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget titleSection(String title, Function()? onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: onPressed != null ? 0 : 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, color: AppTheme.titleColor),
          ),
        ),
        if (onPressed != null)
          AppTextButton(text: "Lihat semua", onPressed: onPressed)
      ],
    );
  }

  Widget summaryCard({
    required String title,
    required Function()? onSeeAll,
    bool notFound = false,
    bool isLoading = false,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.grey.withOpacity(.2),
            offset: const Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 6),
            child: titleSection(title, onSeeAll),
          ),
          isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: AppLoading(),
                )
              : !notFound
                  ? child
                  : const Column(
                      children: [
                        SizedBox(height: 40),
                        Icon(
                          Icons.content_paste_search_rounded,
                          size: 40,
                          color: Color(0xFF98a6ad),
                        ),
                        Text("Tidak Ada Data"),
                        SizedBox(height: 60),
                      ],
                    ),
        ],
      ),
    );
  }
}
