import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/faculty/portions.dart';
import 'package:eg/screens/faculty/portions_display.dart';
import 'package:flutter/material.dart';
import '../../models/students/timetable_model.dart'; // Replace with your actual model file
import '../../models/students/portions_model.dart'; // Add this import for Portion model
import '../../services/students/timetable_service.dart'; // Replace with your actual service file
import '../../services/students/portions_service.dart'; // Add this import for Portion service
import '../../utils/constants.dart';
import '../../widgets/pdf_viewer_page.dart';
import '../../widgets/full_screen_img.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Set<String> expandedClasses = {}; // Stores which classes are expanded
  bool isLoading = true; // Loading state
  bool isPortionsLoading = true; // Loading state for portions

  Timetable? standardTimetable;
  Map<String, Timetable>? classTimetables;
  List<Portion> portions = [];

  @override
  void initState() {
    super.initState();
    fetchTimetable();
    fetchPortions();
  }

  Future<void> fetchTimetable() async {
    try {
      String accessToken = AppConfig.accessToken; 

      // Fetch standard timetable
      standardTimetable = await TimetableService.getStandardTimetable(accessToken);

      // Fetch class-specific timetables
      classTimetables = await TimetableService.getClassTimetables(accessToken);

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching timetable: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchPortions() async {
    try {
      String accessToken = AppConfig.accessToken;
      portions = await PortionService.fetchPortions(accessToken);
      setState(() {
        isPortionsLoading = false;
      });
    } catch (error) {
      print("Error fetching portions: $error");
      setState(() {
        isPortionsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Class Timetable")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Standard Timetable",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _buildTimetableTable(standardTimetable),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: classTimetables?.length ?? 0,
                      itemBuilder: (context, index) {
                        String className = classTimetables!.keys.elementAt(index);
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (expandedClasses.contains(className)) {
                                    expandedClasses.remove(className);
                                  } else {
                                    expandedClasses.add(className);
                                  }
                                });
                              },
                              child: Card(
                                color: Colors.blueAccent,
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(className,
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.white)),
                                      Icon(
                                        expandedClasses.contains(className)
                                            ? Icons.expand_less
                                            : Icons.expand_more,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (expandedClasses.contains(className))
                              _buildTimetableTable(classTimetables![className]!),
                          ],
                        );
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    const Text("Uploaded Portions",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    isPortionsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : portions.isEmpty
                            ? const Center(child: Text("No portions available"))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: portions.length,
                                itemBuilder: (context, index) {
                                  Portion portion = portions[index];
                                  return Card(
                                    elevation: 4,
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${portion.subject} - ${portion.standard}",
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Text("Academic Year: ${portion.academicYear}"),
                                          const SizedBox(height: 5),
                                          Text("Description: ${portion.description}"),
                                          const SizedBox(height: 5),
                                          Text("Reference: ${portion.reference}"),
                                          const SizedBox(height: 5),
                                          Text("Last Updated: ${portion.lastUpdated}"),
                                          const SizedBox(height: 5),
                                          if (portion.units.isNotEmpty)
                                            Text("Units: ${portion.units.join(", ")}"),
                                          if (portion.titles.isNotEmpty)
                                            Text("Titles: ${portion.titles.join(", ")}"),
                                          if (portion.image != null)
                                            GestureDetector(
                                              onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImagePage(imageUrl: portion.image!),
            ),
          );
        },
                                            child: Image.network(portion.image!,
                                                height: 100, fit: BoxFit.cover),
                                            ),
                                          if (portion.document != null)
                                            TextButton(
                                              onPressed: () {
                                                // Open document in browser
                                               
    if (portion.document != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerPage(pdfUrl: portion.document!),
        ),
      );
    }
  
                                              },
                                              child: const Text(
                                                "View Document",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostPortionScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(AppConstants.mainColor),
                          elevation: WidgetStateProperty.all(5)),
                      child: const Text(
                        'Post Portions',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTimetableTable(Timetable? timetable) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          border: TableBorder.all(color: Colors.black),
          columns: _generateColumns(),
          rows: _generateRows(timetable),
        ),
      ),
    );
  }

  List<DataColumn> _generateColumns() {
    return [
      const DataColumn(label: Text("Day", style: TextStyle(fontWeight: FontWeight.bold))),
      ...List.generate(11, (index) => DataColumn(label: Text("Period ${index + 1}"))),
    ];
  }

  List<DataRow> _generateRows(Timetable? timetable) {
    return timetable!.schedule.entries.map((entry) {
      return DataRow(cells: [
        DataCell(Text(entry.key.substring(0, 3).toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold))),
        ...entry.value.map((subject) => DataCell(Text(subject.isNotEmpty ? subject : "-"))),
      ]);
    }).toList();
  }
}
