import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class PDFViewerPage extends StatelessWidget {
//   final String pdfUrl;

//   PDFViewerPage({required this.pdfUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("View Document")),
//       body: SfPdfViewer.network(pdfUrl), // Works on Web & Mobile!
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PDFViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerPage({super.key, required this.pdfUrl});

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(pdfUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $pdfUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("View Document")),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          child: const Text("Open PDF"),
        ),
      ),
    );
  }
}
