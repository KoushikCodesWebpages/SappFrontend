import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/students/portions_model.dart';
import '../../services/students/portions_service.dart';
import '../../widgets/full_screen_img.dart';
import '../../utils/constants.dart';

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
              ? const Center(
                  child: Text(
                    "Portions not uploaded yet",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: portions.length,
                  itemBuilder: (context, index) {
                    Portion portion = portions[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Subject Name
                            Text(
                              portion.subject,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.mainColor,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Academic Details
                            _infoRow("Academic Year", portion.academicYear),
                            _infoRow("Standard", portion.standard),

                            const SizedBox(height: 8),

                            // Description
                            _sectionTitle("Description"),
                            Text(
                              portion.description,
                              style: const TextStyle(fontSize: 14),
                            ),

                            // Reference
                            if (portion.reference.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              _sectionTitle("Reference"),
                              Text(
                                portion.reference,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],

                            const SizedBox(height: 10),

                            // Display Image if present
                            if (portion.image != null && portion.image!.isNotEmpty)
                              _buildImagePreview(portion.image!),

                            // Display Document if present
                            if (portion.document != null &&
                                portion.document!.isNotEmpty)
                              _buildDocumentButton(portion.document!),

                            // List of Units & Titles
                            const SizedBox(height: 10),
                            _sectionTitle("Units"),
                            _buildUnitList(portion.units, portion.titles),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  // Widget for displaying info rows
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  // Widget for section title styling
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppConstants.mainColor,
      ),
    );
  }

  // Widget for Image Preview
  Widget _buildImagePreview(String imageUrl) {
    return Column(
      children: [
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImagePage(imageUrl: imageUrl),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Widget for Document Button
  Widget _buildDocumentButton(String docUrl) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => _openUrl(docUrl),
        icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
        label: const Text("Open Document"),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.mainColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // Widget for Unit List
  Widget _buildUnitList(List<String> units, List<String> titles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(units.length, (i) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          color: AppConstants.mainColor,
          child: ListTile(
            leading: const Icon(Icons.book, color: Colors.white),
            title: Text(
              units[i],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(titles[i]),
          ),
        );
      }),
    );
  }

  // Function to open URL
  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }
}
