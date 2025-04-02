import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroceryTile extends StatefulWidget {
  final String name;
  final DateTime date;
  final int quantity;
  final String importance;
  final VoidCallback onChecked;
  final Color color;

  final void Function(DateTime, int, String) onEdit;
  const GroceryTile({
    super.key,
    required this.name,
    required this.date,
    required this.quantity,
    required this.importance,
    required this.onChecked,
    required this.color,
    required this.onEdit,  // New callback for updates
  });

  @override
  _GroceryTileState createState() => _GroceryTileState();
}

class _GroceryTileState extends State<GroceryTile> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late int _selectedQuantity;
  late String _selectedImportance;
  bool _isChecked = false; // Add a state variable for the checkbox

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
    _selectedTime = TimeOfDay.fromDateTime(widget.date);
    _selectedQuantity = widget.quantity;
    _selectedImportance = widget.importance;
  }

  void _openEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Edit Grocery Item'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Date Picker
                ListTile(
                  title: 
                    Text("Date: ${
                      DateFormat('MMMM d, yyyy').format(_selectedDate)
                      }"),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (newDate != null) {
                      setDialogState(() {
                        _selectedDate = newDate;
                      });
                    }
                  },
                ),

                // Time Picker
                ListTile(
                  title: 
                    Text('Time: ${_selectedTime.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (newTime != null) {
                      setDialogState(() {
                        _selectedTime = newTime;
                      });
                    }
                  },
                ),

                // Importance Selection
                DropdownButtonFormField<String>(
                  value: _selectedImportance,
                  items: ['Low', 'Medium', 'High']
                      .map((level) => DropdownMenuItem(
                        value: level, child: Text(level)))
                      .toList(),
                  onChanged: (newValue) {
                    setDialogState(() {
                      _selectedImportance = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Importance'),
                ),

                // Quantity Slider
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quantity: $_selectedQuantity'),
                    Slider(
                      value: _selectedQuantity.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 99,
                      label: _selectedQuantity.toString(),
                      onChanged: (double value) {
                        setDialogState(() {
                          _selectedQuantity = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  widget.onEdit(
                    DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      _selectedTime.hour,
                      _selectedTime.minute,
                    ),
                    _selectedQuantity,
                    _selectedImportance,
                  );
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Section: Name, Date, Importance
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Row(
                    children: [
                      Text(widget.name, style: GoogleFonts.lato(fontSize: 18, 
                        fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      //Icon(Icons.bottle, size: 18),
                      Icon(Symbols.salinity, size: 18),
                      //const FaIcon(FontAwesomeIcons.satellite, size: 18), 
                    ],
                  ),
                  
                  // Date & Time
                  Text(
                    DateFormat('MMMM d hh:mm a').format(widget.date),
                    style: GoogleFonts.lato(
                      fontSize: 14, color: Colors.grey[600]),
                  ),
                  
                  // Importance
                  Text(
                    widget.importance,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.importance == 'High' ? Colors.red : (
                        widget.importance == 'Medium' ? Colors.orange : 
                        Colors.green),
                    ),
                  ),
                ],
              ),
            ),

            // Right Section: Quantity, Checkbox & Edit
            Column(
              children: [
                // Edit Icon
                IconButton(
                  icon: Icon(Icons.edit, size: 18, color: Colors.grey),
                  onPressed: _openEditDialog,
                ),

                Row(
                  children: [
                    // Quantity
                    Text(widget.quantity.toString(), 
                      style: GoogleFonts.lato(fontSize: 16, 
                        fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),

                    // Checkbox
                    Checkbox(
                     value: _isChecked, // Use the state variable
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!; // Update the state
                        });
                        widget.onChecked(); // Call the callback if needed
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
