import 'package:aldi_test/theme/theme.dart';
import 'package:flutter/material.dart';

class AppDropDown extends StatelessWidget {
  final String? label;
  final String hintText;
  final String? value;
  final bool hideLabel;
  final List<String> items;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  const AppDropDown({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    this.label,
    this.validator,
    this.onChanged,
    this.hideLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideLabel && label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.titleColor,
              ),
            ),
          ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            validator: validator,
            hint: Text(
              hintText,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.capColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            elevation: 1,
            isDense: true,
            isExpanded: true,
            value: value,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: AppTheme.fontFamily,
            ),
            icon: const Icon(
              Icons.expand_more_rounded,
              color: AppTheme.capColor,
            ),
            onChanged: onChanged,
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: AppTheme.textFieldInputDecoration.copyWith(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 14,
              ),
            ),
            items: items.map((e) => buildMenuItem(e)).toList(),
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((String item) {
                return Container(
                  alignment: Alignment.centerLeft,
                  constraints: const BoxConstraints(minWidth: 100),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.titleColor,
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.titleColor,
            fontFamily: AppTheme.fontFamily,
          ),
        ),
      );
}
