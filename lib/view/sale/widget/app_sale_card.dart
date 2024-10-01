import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/model/sale.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/widget/app_card_list.dart';
import 'package:aldi_test/widget/app_square_initial.dart';
import 'package:flutter/material.dart';

class AppSaleCard extends StatelessWidget {
  final Sale sale;
  final bool isLast;
  final Function(Sale) onTap;
  const AppSaleCard({
    super.key,
    required this.sale,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(sale),
      child: AppCardList(
        isLast: isLast,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
          child: Row(
            children: [
              AppSquareInitial(initial: sale.initial),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            sale.customer,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          moneyFormatter(sale.total),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          dateFormatUI(sale.dateTime),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.capColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          dateFormatUI(sale.dateTime, format: "HH:mm:ss"),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.capColor,
                          ),
                        ),
                      ],
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
