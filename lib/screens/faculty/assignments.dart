import 'package:eg/utils/constants.dart';
import 'package:eg/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../../models/faculty/assignments_model.dart';
import '../../services/faculty/assignments_service.dart';

class FacAssignments extends StatefulWidget {
  @override
  FacAssignmentsState createState() => FacAssignmentsState();
}

class FacAssignmentsState extends State<FacAssignments> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subjectController = TextEditingController();
  final _markController = TextEditingController();
  final _standardController = TextEditingController();
  final _sectionController = TextEditingController();
  final _academicYearController = TextEditingController();
  DateTime _dueDate = DateTime.now();

  final AssignmentService _assignmentService = AssignmentService();

  Future<void> _submitAssignment() async {
    if (_formKey.currentState!.validate()) {
      Assignment assignment = Assignment(
        title: _titleController.text,
        description: _descriptionController.text,
        subject: _subjectController.text,
        mark: int.parse(_markController.text),
        standard: _standardController.text,
        section: _sectionController.text,
        academicYear: _academicYearController.text,
        dueDate: _dueDate,
        createdBy: AppConstants.name,
      );

      try {
        bool success = await _assignmentService.postAssignment(assignment);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Assignment posted successfully!")),
          );
          _formKey.currentState!.reset();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error posting assignment: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Assignment", style: TextStyle(color: Colors.white),), backgroundColor: AppConstants.mainColor,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              //_buildTextField(_titleController, "Title"),
              TextInputBox(control: _titleController, label: "Title",),
              SizedBox(height: 10,),
              TextInputBox(control: _descriptionController, label: "Description", ),
              SizedBox(height: 10,),
              TextInputBox(control: _subjectController, label: "Subject",),
              SizedBox(height: 10,),
              TextInputBox(control: _markController, label: "Marks",),
              SizedBox(height: 10,),
              TextInputBox(control: _standardController, label: "Standard",),
              SizedBox(height: 10,),
              TextInputBox(control: _sectionController, label: "Section",),
              SizedBox(height: 10,),
              TextInputBox(control: _academicYearController, label: "Academic Year",),
              // _buildTextField(_descriptionController, "Description"),
              // _buildTextField(_subjectController, "Subject"),
              // _buildTextField(_markController, "Marks", isNumber: true),
              // _buildTextField(_standardController, "Standard"),
              // _buildTextField(_sectionController, "Section"),
              // _buildTextField(_academicYearController, "Academic Year"),
              //_buildTextField(_createdByController, "Created By"),

              // Due Date Picker
              ListTile(
                title: Text("Due Date: ${_dueDate.toLocal()}".split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null && pickedDate != _dueDate) {
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  }
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitAssignment,
                style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(AppConstants.mainColor),
                          elevation: WidgetStateProperty.all(5)
                        ),
                        
                        child: Text('Post Assignment', style: TextStyle(fontSize: 16, color: Colors.white),),
                //child: Text("Post Assignment"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for text fields
  // Widget _buildTextField(TextEditingController controller, String label,
  //     {bool isNumber = false}) {
  //   return TextFormField(
  //     controller: controller,
  //     decoration: InputDecoration(labelText: label),
  //     keyboardType: isNumber ? TextInputType.number : TextInputType.text,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return "$label is required";
  //       }
  //       return null;
  //     },
  //   );
  // }
}
