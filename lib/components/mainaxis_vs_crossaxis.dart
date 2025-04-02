import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AlignmentDemo(),
    debugShowCheckedModeBanner: false,
  ));
}

class AlignmentDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('mainAxisAlignment vs crossAxisAlignment')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            
            /// ROW DEMO SECTION
            Text('Row: mainAxisAlignment', style: 
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            
            _buildRow(MainAxisAlignment.start, 'Start'),
            _buildRow(MainAxisAlignment.center, 'Center'),
            _buildRow(MainAxisAlignment.end, 'End'),
            _buildRow(MainAxisAlignment.spaceBetween, 'Space Between'),
            _buildRow(MainAxisAlignment.spaceAround, 'Space Around'),
            _buildRow(MainAxisAlignment.spaceEvenly, 'Space Evenly'),
            
            SizedBox(height: 20),

            /// ROW WITH CROSSAXISALIGNMENT DEMO
            Text('Row: crossAxisAlignment', style: 
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildRowWithCrossAlignment(CrossAxisAlignment.start, 'Start'),
            _buildRowWithCrossAlignment(CrossAxisAlignment.center, 'Center'),
            _buildRowWithCrossAlignment(CrossAxisAlignment.end, 'End'),

            SizedBox(height: 20),

            /// COLUMN DEMO SECTION
            Text('Column: mainAxisAlignment', style: 
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            
            _buildColumn(MainAxisAlignment.start, 'Start'),
            _buildColumn(MainAxisAlignment.center, 'Center'),
            _buildColumn(MainAxisAlignment.end, 'End'),
            _buildColumn(MainAxisAlignment.spaceBetween, 'Space Between'),
            _buildColumn(MainAxisAlignment.spaceAround, 'Space Around'),
            _buildColumn(MainAxisAlignment.spaceEvenly, 'Space Evenly'),
            
            SizedBox(height: 20),

            /// COLUMN WITH CROSSAXISALIGNMENT DEMO
            Text('Column: crossAxisAlignment', style: 
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildColumnWithCrossAlignment(
              CrossAxisAlignment.start, 'Start'),
            _buildColumnWithCrossAlignment(CrossAxisAlignment.center, 'Center'),
            _buildColumnWithCrossAlignment(CrossAxisAlignment.end, 'End'),
            
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Row with different mainAxisAlignment values
  Widget _buildRow(MainAxisAlignment alignment, String title) {
    return Column(
      children: [
        Text(title, style: 
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Container(
          color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: alignment,
            children: [
              _box(Colors.red),
              _box(Colors.green),
              _box(Colors.blue),
            ],
          ),
        ),
      ],
    );
  }

  /// Row with different crossAxisAlignment values
  Widget _buildRowWithCrossAlignment(
    CrossAxisAlignment alignment, String title) {
    return Column(
      children: [
        Text(title, style: 
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Container(
          color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: alignment,
            children: [
              _box(Colors.red, height: 50),
              _box(Colors.green, height: 80),
              _box(Colors.blue, height: 60),
            ],
          ),
        ),
      ],
    );
  }

  /// Column with different mainAxisAlignment values
  Widget _buildColumn(MainAxisAlignment alignment, String title) {
    return Column(
      children: [
        Text(title, style: 
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Container(
          color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          height: 150,
          child: Column(
            mainAxisAlignment: alignment,
            children: [
              _box(Colors.red),
              _box(Colors.green),
              _box(Colors.blue),
            ],
          ),
        ),
      ],
    );
  }

  /// Column with different crossAxisAlignment values
  Widget _buildColumnWithCrossAlignment(CrossAxisAlignment alignment, 
    String title){
    return Column(
      children: [
        Text(title, style: 
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Container(
          color: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(10),
          height: 150,
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              _box(Colors.red, width: 50),
              _box(Colors.green, width: 100),
              _box(Colors.blue, width: 75),
            ],
          ),
        ),
      ],
    );
  }

  /// Helper function to create a box widget
  Widget _box(Color color, {double width = 50, double height = 50}) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(5),
      color: color,
    );
  }
}
