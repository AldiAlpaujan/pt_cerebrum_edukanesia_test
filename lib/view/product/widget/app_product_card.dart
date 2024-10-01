import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/model/product.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/widget/app_card_list.dart';
import 'package:aldi_test/widget/app_square_initial.dart';
import 'package:flutter/widgets.dart';

class AppProductCard extends StatelessWidget {
  final Product product;
  final bool isLast;
  final Function(Product) onTap;
  const AppProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.isLast,
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
              AppSquareInitial(initial: product.initial),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          moneyFormatter(product.price),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.capColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Kategori : ${product.category}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.capColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
