import "package:built_collection/built_collection.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/filter_tag.dart";

class FilterChips<T extends FilterTag> extends StatefulWidget {
  final List<T> items;
  final BuiltSet<int> initialSelected;
  final void Function(BuiltSet<int>) onChange;

  const FilterChips(
      {Key? key,
      required this.items,
      required this.initialSelected,
      required this.onChange})
      : super(key: key);

  @override
  State<FilterChips<T>> createState() => _FilterChipsState<T>();
}

class _FilterChipsState<T extends FilterTag> extends State<FilterChips<T>> {
  late final Set<int> selected;

  @override
  void initState() {
    // Create a copy
    selected = widget.initialSelected.toSet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    final children = widget.items.map((item) {
      final isSelected = selected.contains(item.id);

      return ChoiceChip(
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: primaryColor,
          ),
        ),
        selectedColor: primaryColor,
        label: Text(
          item.name,
          style: TextStyle(
            color: isSelected ? Colors.white : primaryColor,
          ),
        ),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            if (isSelected) {
              selected.remove(item.id);
            } else {
              selected.add(item.id);
            }
          });

          widget.onChange(selected.build());
        },
      );
    }).toList();

    return Wrap(
      children: children,
      spacing: 8.0,
    );
  }
}
