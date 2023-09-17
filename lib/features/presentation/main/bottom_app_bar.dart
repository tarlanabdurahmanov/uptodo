import 'package:flutter/material.dart';

class BottomAppBarItem {
  final Widget icon;
  final Widget activeIcon;
  final String text;

  BottomAppBarItem({
    required this.icon,
    required this.activeIcon,
    required this.text,
  });
}

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({
    super.key,
    required this.items,
    this.centerItemText = '',
    this.height = 60.0,
    this.iconSize = 24.0,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) {
    assert(items.length == 2 || items.length == 4);
  }
  final List<BottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(
      items.length >> 1,
      const Expanded(
        child: SizedBox.shrink(),
      ),
    );

    return BottomAppBar(
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildTabItem({
    required BottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    Widget icon = _selectedIndex == index ? item.activeIcon : item.icon;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => onPressed(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              Text(
                item.text,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}
