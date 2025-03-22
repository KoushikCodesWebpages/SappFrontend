import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/students/portions_model.dart';
import '../../services/students/portions_service.dart';
import 'package:eg/utils/constants.dart';
import '../../widgets/full_screen_img.dart';

class StuPortionScreen extends StatefulWidget {
  final String accessToken;

  const StuPortionScreen({super.key, required this.accessToken});

  @override
  StuPortionScreenState createState() => StuPortionScreenState();
}

class StuPortionScreenState extends State<StuPortionScreen> {
  List<Portion> portions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPortions();
  }

  Future<void> fetchPortions() async {
    try {
      List<Portion> fetchedPortions =
          await PortionService.fetchPortions(widget.accessToken);
      setState(() {
        portions = fetchedPortions;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error fetching portions: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : portions.isEmpty
              ? const Center(child: Text("No portions available"))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: portions.length,
                  itemBuilder: (context, index) {
                    Portion portion = portions[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Subject Name
                            Text(
                              portion.subject,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),

                            // Academic Details
                            Text(
                              "Academic Year: ${portion.academicYear}",
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Standard: ${portion.standard}",
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 6),

                            // Description
                            Text(
                              "Description: ${portion.description}",
                              style: const TextStyle(fontSize: 14),
                            ),

                            // Reference
                            Text(
                              "Reference: ${portion.reference}",
                              style: const TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(height: 10),

                            // Display Image if present
                            // if (portion.image != null && portion.image!.isNotEmpty)
                            //   Column(
                            //     children: [
                            //       Image.network(
                            //         portion.image!,
                            //         height: 150,
                            //         width: double.infinity,
                            //         fit: BoxFit.cover,
                            //       ),
                            //       const SizedBox(height: 10),
                            //     ],
                            //   ),

                            // Display Image if present
if (portion.image != null && portion.image!.isNotEmpty)
  Column(
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImagePage(imageUrl: portion.image!),
            ),
          );
        },
        child: Image.network(
          portion.image!,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(height: 10),
    ],
  ),


                            // Display Document if present
                            if (portion.document != null &&
                                portion.document!.isNotEmpty)
                              ElevatedButton.icon(
                                onPressed: () => _openUrl(portion.document!),
                                icon: const Icon(Icons.picture_as_pdf),
                                label: const Text("Open Document"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                              ),

                            // List of Units & Titles
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(portion.units.length, (i) {
                                return ListTile(
                                  leading: const Icon(Icons.book, color: Colors.blue),
                                  title: Text(portion.units[i],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  subtitle: Text(portion.titles[i]),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  // Function to open URL (for PDF or external documents)
  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }
}
