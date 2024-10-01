import 'package:aldi_test/data/sale.data.dart';
import 'package:aldi_test/helper/dialog.dart';
import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/model/sale.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/product/widget/app_product_card.dart';
import 'package:aldi_test/widget/app_custom_appbar.dart';
import 'package:aldi_test/widget/app_fix_btm_btn.dart';
import 'package:aldi_test/widget/app_key_value_item.dart';
import 'package:aldi_test/widget/app_loading.dart';
import 'package:aldi_test/widget/app_square_initial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleDetailPage extends StatefulWidget {
  final Sale sale;
  const SaleDetailPage({super.key, required this.sale});

  static open(Sale sale) async => await Get.to(SaleDetailPage(sale: sale));

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  final _loading = false.obs;
  final _sale = Rx<Sale?>(null);

  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  Sale get sale => _sale.value!;
  set sale(Sale value) => _sale.value = value;

  getData() async {
    loading = true;
    final result = await SaleData.getSingle(sale.id);
    loading = false;
    if (result != null) sale = result;
  }

  formPage() async {
    await Get.toNamed(Routes.saleForm, arguments: sale);
    await getData();
  }

  deleteData() async {
    confirm(
      message: "Apakah Anda yakin ingin menghapus data penjualan tersebut?",
      onOk: () async {
        Get.back();
        waitingDialog();
        final result = await SaleData.delete(sale.id);
        Get.back();
        if (result) {
          Get.back();
          info(message: "Data penjualan berhasil dihapus");
        }
      },
    );
  }

  @override
  void initState() {
    sale = widget.sale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: "Detail Penjualan",
        actions: [
          IconButton(
            onPressed: deleteData,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (loading) return const AppLoading();
          return Column(
            children: [
              Expanded(child: detail()),
              AppFixBtmButton(
                onPressed: formPage,
                label: "Ubah Penjualan",
              ),
            ],
          );
        },
      ),
    );
  }

  Widget detail() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.padding),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppSquareInitial(initial: sale.initial),
                const SizedBox(width: 10),
                Text(
                  sale.customer,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.titleColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            AppKeyValueItem(
              keyItem: "Tanggal",
              value: dateFormatUI(
                sale.dateTime,
                format: "dd MMMM yyyy HH:mm:ss",
              ),
              padding: const EdgeInsets.only(bottom: 8),
            ),
            AppKeyValueItem(
              keyItem: "Total",
              value: moneyFormatter(sale.total),
              padding: const EdgeInsets.only(bottom: 8),
            ),
            AppKeyValueItem(
              keyItem: "Bayar",
              value: moneyFormatter(sale.payment),
              padding: const EdgeInsets.only(bottom: 8),
            ),
            AppKeyValueItem(
              keyItem: "Diubah",
              value: sale.updateAt == null
                  ? "-"
                  : dateFormatUI(
                      sale.updateAt!,
                      format: "dd MMMM yyyy HH:mm:ss",
                    ),
              padding: const EdgeInsets.only(bottom: 14),
            ),
            const Text(
              "Detail Produk",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.titleColor,
              ),
            ),
            ...sale.products.map(
              (e) => AppProductCard(
                product: e,
                onTap: (v) {},
                isLast: e.id == sale.products.last.id,
                withPadding: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
