part of '../views.dart';

class DropDownMenuWrapper extends StatelessWidget {
  const DropDownMenuWrapper(
      {super.key,
      required this.currentSelected,
      required this.list,
      required this.title,
      required this.onSelected,
      required this.width,
      required this.isActive}); 
  final List<DropdownMenuEntry<String>>? list;
  final bool isActive;
  final String currentSelected;
  final String title;
  final double width;
  final Function(String?)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DropdownMenuCustom(
          width: width,
          isActive: isActive,
          initialSelection: currentSelected,
          list: list,
          onDropDownMenuClick: onSelected),
    ]);
  }
}

class DropdownMenuCustom extends StatefulWidget {
  final List<DropdownMenuEntry<String>>? list;
  final String? initialSelection;
  final double? width;
  final void Function(String?)? onDropDownMenuClick;
  final bool? isActive;
  const DropdownMenuCustom(
      {super.key,
      @required this.list,
      @required this.initialSelection,
      required this.onDropDownMenuClick,
      @required this.width,
      @required this.isActive});

  @override
  State<DropdownMenuCustom> createState() => _DropdownMenuCustomState();
}

class _DropdownMenuCustomState extends State<DropdownMenuCustom> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<String>>? list = widget.list;
    
    return list != null
        ? DropdownMenu<String>(
            width: widget.width,
            initialSelection: widget.initialSelection,
            onSelected: widget.onDropDownMenuClick,
            dropdownMenuEntries: list,
            enabled: widget.isActive!,
          )
        : const CircularProgressIndicator();
  }
}
