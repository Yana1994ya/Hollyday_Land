import "package:flutter/material.dart";

class FilterChips {
  static Widget choiceChips<T>({
    required List<T> items,
    required bool Function(T) isSelected,
    required void Function(T) toggle,
    required String Function(T) title,
    required ColorScheme colorScheme,
  }) {
    final childern = items.map((item) {
      final selected = isSelected(item);

      return ChoiceChip(
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
            side: BorderSide(
          color: colorScheme.primary,
        )),
        selectedColor: colorScheme.primary,
        label: Text(
          title(item),
          style: TextStyle(
            color: selected ? Colors.white : colorScheme.primary,
          ),
        ),
        selected: selected,
        onSelected: (_) {
          toggle(item);
        },
      );
    }).toList();

    return Wrap(
      children: childern,
      spacing: 8.0,
    );
  }
}
