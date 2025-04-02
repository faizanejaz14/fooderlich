//grocery_item_screen.dart
import 'package:flutter/material.dart';
import '../models/grocery_item.dart';
import '../models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'grocery_tile_screen.dart';


class GroceryItemScreen extends StatefulWidget{
  final Function (GroceryItem) onCreate;
  final Function (GroceryItem) onUpdate;

  final GroceryItem? originalItem;

  final bool isUpdating;

  const GroceryItemScreen({
    super.key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  }): isUpdating = (originalItem != null);

  @override
  GroceryItemScreenState createState() => 
  GroceryItemScreenState();

}

class GroceryItemScreenState extends State<GroceryItemScreen>{
  final _nameController = TextEditingController ();
  String _name = '';
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;
  @override
  void initState(){
    super.initState();
    final originalItem = widget.originalItem;

    if(originalItem != null){
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(
        hour: date.hour, 
        minute: date.minute);
      _dueDate = originalItem.date;
    }
    _nameController.addListener((){
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
   void dispose(){
     _nameController.dispose();
     super.dispose();
   }
    Importance _stringToImportance(String importance) {
      switch (importance.toLowerCase()) {
        case 'high':
          return Importance.high;
        case 'medium':
          return Importance.medium;
        case 'low':
          return Importance.low;
        default:
          return Importance.low; // Default fallback
      }
    }

    String _importanceToString(Importance importance){
      switch (importance) {
        case Importance.high:
          return 'High';
        case Importance.medium:
          return 'Medium';
        case Importance.low:
          return 'Low';
        default:
          return 'Low'; // Default fallback
      }
    }
    void _updateGroceryItem(
        DateTime newDate, int newQuantity, String newImportance) {
      setState(() {
        _dueDate = newDate;
        _currentSliderValue = newQuantity;
        _importance = _stringToImportance(newImportance);
      });
    }
  @override
   Widget build(BuildContext context){
    //return Container (color: Colors.amber);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (_nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a name')),
                );

                return;
              }

              final groceryItem = GroceryItem(
                id: widget.originalItem?.id ?? DateTime.now().toString(),
                name: _nameController.text,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(
                  _dueDate.year,
                  _dueDate.month,
                  _dueDate.day,
                  _timeOfDay.hour,
                  _timeOfDay.minute,
                ),
              );

              if (widget.isUpdating) {
                widget.onUpdate(groceryItem);
              } else {
                widget.onCreate(groceryItem);
              }
            },
            icon: const Icon(Icons.check),
          )
        ],
        elevation: 0.0,
        title: Text('Grocery Item'),
      ),
      body: Container(padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            buildColorPicker(context),
            buildQuantitySlider(),
            // GroceryTile(
            //   name: 'More Salt',
            //   date: _dueDate,
            //   quantity: _currentSliderValue,
            //   importance: _importanceToString(_importance),
            //   onChecked: () {},
            //   color: Colors.red,
            //   onEdit: _updateGroceryItem,
            // ),            
          ] ,
          ),
      )
    );
   } 

   Widget buildNameField(){
    return Column(
      children: [
        Text('Item Name'),
        TextField(
          controller: _nameController,
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: 'E.g. Apples, Bananas, 1Kg of Salt etc',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            )
          ),)
      ],
    );
   }

   Widget buildImportanceField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Importance'),
        Wrap(
          spacing: 10,
          children: [
            ChoiceChip(
              selected: _importance == Importance.low,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              selected: _importance == Importance.medium,
              label:
                  const Text('medium', style: TextStyle(color: Colors.white)),
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selected: _importance == Importance.high,
              label: const Text('high', style: TextStyle(color: Colors.white)),
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            )
          ],
        )
      ],
    );
  }

  Widget buildDateField(BuildContext context) {
    // 1
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // 2
    Row(
    // 3
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    // 4
    Text(
    'Date',
    style: GoogleFonts.lato(fontSize: 28.0),
    ),
    // 5
    TextButton(
    child: const Text('Select'),
    // 6
    onPressed: () async {
    final currentDate = DateTime.now();
    // 7
    final selectedDate = await showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: currentDate,
    lastDate: DateTime(currentDate.year + 5),
    );
    // 8
    setState(() {
    if (selectedDate != null) {
    _dueDate = selectedDate;
    }
    });
    },
    ),
    ],
    ),
    // 9
    Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
    ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'Time of Day',
    style: GoogleFonts.lato(fontSize: 28.0),
    ),
    TextButton(
    child: const Text('Select'),
    onPressed: () async {
    // 1
    final timeOfDay = await showTimePicker(
    // 2
    initialTime: TimeOfDay.now(),
    context: context,
    );
    // 3
    setState(() {
    if (timeOfDay != null) {
    _timeOfDay = timeOfDay;
    }
    });
    },
    ),
    ],
    ),
    Text(_timeOfDay.format(context)),
    ],
    );
  }

  Widget buildColorPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50.0,
              width: 10.0,
              color: _currentColor,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text('Color'),
          ],
        ),
        TextButton(
          child: const Text('Select Color'),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: BlockPicker(
                      pickerColor: Colors.white,
                      onColorChanged: (color) {
                        setState(
                          () {
                            _currentColor = color;
                          },
                        );
                      }),
                    actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save'))
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

    Widget buildQuantitySlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: GoogleFonts.lato(fontSize: 20.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$_currentSliderValue',
              style: GoogleFonts.lato(
                fontSize: 18.0, 
                fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Slider(
                value: _currentSliderValue.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                activeColor: _currentColor,
                label: _currentSliderValue.toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value.toInt();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

}