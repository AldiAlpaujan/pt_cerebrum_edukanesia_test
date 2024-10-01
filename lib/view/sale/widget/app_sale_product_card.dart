import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/model/product.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/widget/app_card_list.dart';
import 'package:aldi_test/widget/app_square_initial.dart';
import 'package:flutter/material.dart';

class AppSaleProductCard extends StatelessWidget {
  final Product product;
  final bool isLast;
  final int inCart;
  final Function(Product) onTap;
  final Function(Product) onRemove;
  const AppSaleProductCard({
    super.key,
    required this.product,
    required this.isLast,
    required this.inCart,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(product),
      child: AppCardList(
        isLast: isLast,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
          child: Row(
            children: [
              AppSquareInitial(
                initial: inCart.toString(),
                bgColor: const Color(0xFFEEF2F8),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${product.category} - ${moneyFormatter(product.price)}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.capColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onRemove(product),
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFEEF2F8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.remove,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
