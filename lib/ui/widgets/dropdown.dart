import 'package:uxpress_admin/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({Key key, this.onItemChange, this.items, this.hint, this.initialPos=0}) : super(key: key);

  Function(String) onItemChange;
  List<String> items;
  String hint;
  int initialPos;

  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  String initialValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialValue = widget.items[widget.initialPos];
    
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(Icons.arrow_downward),
      iconSize: 16,
      elevation: 16,
      value: initialValue,
      hint: Text(widget.hint),
      underline: Container(
        width: getWidth(context) * 0.5,
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: (val){
        setState(() {
          initialValue = val;
        });
        widget.onItemChange(val);
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}