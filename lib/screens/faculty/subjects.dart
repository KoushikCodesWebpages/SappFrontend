import 'package:eg/config/mapp_config.dart';
import 'package:eg/screens/faculty/portions.dart';
import 'package:flutter/material.dart';
import '../../models/students/timetable_model.dart';
import '../../models/students/portions_model.dart';
import '../../services/students/timetable_service.dart';
import '../../services/students/portions_service.dart';
import '../../utils/constants.dart';
import '../../widgets/full_screen_img.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  Set<String> expandedClasses = {};
  bool isLoading = true;
  bool isPortionsLoading = true;
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
      standardTimetable = await TimetableService.getStandardTimetable(accessToken);
      classTimetables = await TimetableService.getClassTimetables(accessToken);
    } catch (error) {
      print("Error fetching timetable: $error");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _openPDF(String submittedDocumentUrl) async {
    final Uri url = Uri.parse(submittedDocumentUrl!);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $submittedDocumentUrl';
    }
  }

  Future<void> fetchPortions() async {
    try {
      String accessToken = AppConfig.accessToken;
      portions = await PortionService.fetchPortions(accessToken);
    } catch (error) {
      print("Error fetching portions: $error");
    } finally {
      setState(() => isPortionsLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text("Class Timetable", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: AppConstants.mainColor,
        elevation: 4,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Standard Timetable"),
                  _buildTimetableTable(standardTimetable),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Class-wise Timetables"),
                  _buildClassTimetables(),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Uploaded Portions"),
                  _buildPortionsList(),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostPortionScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.mainColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Post Portions',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _buildClassTimetables() {
    return ListView.builder(
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
                  expandedClasses.contains(className)
                      ? expandedClasses.remove(className)
                      : expandedClasses.add(className);
                });
              },
              child: Card(
                color: AppConstants.mainColor,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(className, style: const TextStyle(fontSize: 18, color: Colors.white)),
                      Icon(
                        expandedClasses.contains(className) ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (expandedClasses.contains(className)) _buildTimetableTable(classTimetables![className]!),
          ],
        );
      },
    );
  }

  Widget _buildPortionsList() {
    if (isPortionsLoading) return const Center(child: CircularProgressIndicator());
    if (portions.isEmpty) return const Center(child: Text("No portions available"));

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: portions.length,
      itemBuilder: (context, index) {
        Portion portion = portions[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${portion.subject} - ${portion.standard}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text("Academic Year: ${portion.academicYear}"),
                Text("Description: ${portion.description}"),
                Text("Reference: ${portion.reference}"),
                Text("Last Updated: ${portion.lastUpdated}"),
                if (portion.units.isNotEmpty) Text("Units: ${portion.units.join(", ")}"),
                if (portion.titles.isNotEmpty) Text("Titles: ${portion.titles.join(", ")}"),
                if (portion.image != null)
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImagePage(imageUrl: portion.image!),
                      ),
                    ),
                    child: Image.network(portion.image!, height: 100, fit: BoxFit.cover),
                  ),
                if (portion.document != null)
                  TextButton(
                    onPressed: () =>_openPDF(portion.document!),
                    child: const Text("View Document", style: TextStyle(color: Colors.blue)),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimetableTable(Timetable? timetable) {
  if (timetable == null || timetable.schedule.isEmpty) {
    return const Center(child: Text("No timetable available"));
  }

  int maxPeriods = timetable.schedule.values.map((list) => list.length).fold(0, (a, b) => a > b ? a : b);

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      border: TableBorder.all(color: Colors.black.withOpacity(0.2)),
      columns: _generateColumns(timetable),
      rows: _generateRows(timetable, maxPeriods),
      headingRowColor: MaterialStateProperty.all(AppConstants.mainColor), // Set header bg color
      headingTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Set header text color
    ),
  );
}

List<DataColumn> _generateColumns(Timetable timetable) {
  return [
    const DataColumn(label: Text("PERIOD",)),
    ...timetable.schedule.keys.map((day) => DataColumn(label: Text(day.substring(0, 3).toUpperCase()))),
  ];
}


  List<DataRow> _generateRows(Timetable timetable, int maxPeriods) {
    return List.generate(maxPeriods, (index) {
      return DataRow(cells: [
        DataCell(Text("P${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold))),
        ...timetable.schedule.keys.map((day) {
          return DataCell(Text(index < timetable.schedule[day]!.length ? timetable.schedule[day]![index] : "-"));
        }),
      ]);
    });
  }
}
