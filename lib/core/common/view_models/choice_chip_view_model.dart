//ChoiceChipModel >>

class ChoiceChipModel {
  final String label;
  final bool selected;
  final void Function(bool)? onSelected;
  ChoiceChipModel({
    this.label = "",
    required this.selected,
    this.onSelected,
  });
}
