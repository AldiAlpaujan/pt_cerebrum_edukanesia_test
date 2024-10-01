import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/model/product.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/widget/app_card_list.dart';
import 'package:aldi_test/widget/app_square_initial.dart';
import 'package:flutter/material.dart';

class AppCartCard extends StatelessWidget {
  final Product product;
  final bool isLast;
  final int inCart;
  final Function(Product) onTap;
  final Function(Product) onRemove;
  final Function(int id) onRemoveFromList;
  const AppCartCard({
    super.key,
    required this.product,
    required this.isLast,
    required this.inCart,
    required this.onTap,
    required this.onRemove,
    required this.onRemoveFromList,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardList(
      isLast: isLast,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSquareInitial(
            initial: product.initial,
            bgColor: const Color(0xFFEEF2F8),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Text(
                  "Harga : ${moneyFormatter(product.price)}",
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppTheme.capColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Kategori : ${product.category}",
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppTheme.capColor,
                  ),
                ),
                Row(
                  children: [
                    qtyCount(),
                    const Spacer(),
                    IconButton(
                      onPressed: () => onRemoveFromList(product.id!),
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget qtyCount() {
    return Row(
      children: [
        button(Icons.remove, inCart > 1, () => onRemove(product)),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: Container(
            color: Colors.white,
            height: 30,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: inCart.toString().length < 4 ? 0 : 8.0,
                ),
                child: Text(
                  inCart.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ),
        button(Icons.add, true, () => onTap(product)),
      ],
    );
  }

  Widget button(IconData icon, bool isActive, Function() onTap) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor : const Color(0xFFEEF2F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
