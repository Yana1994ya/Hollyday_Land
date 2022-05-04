import "package:built_collection/built_collection.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/difficulty.dart";

class DifficultyFilterChips extends StatefulWidget {
  final BuiltSet<Difficulty> initialSelected;
  final void Function(BuiltSet<Difficulty>) onChange;

  const DifficultyFilterChips(
      {Key? key, required this.initialSelected, required this.onChange})
      : super(key: key);

  @override
  State<DifficultyFilterChips> createState() => _DifficultyFilterChipsState();
}

class _DifficultyFilterChipsState extends State<DifficultyFilterChips> {
  late final Set<Difficulty> selected;

  @override
  void initState() {
    //toSet Create a copy
    selected = widget.initialSelected.toSet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    final children = Difficulty.values.map((item) {
      final isSelected = selected.contains(item);

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
              selected.remove(item);
            } else {
              selected.add(item);
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
