import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

final class PdfView extends StatelessWidget {
  const PdfView({super.key, required this.path});
  final String path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PDFView(
          filePath: path,
        ),
      ),
    );
  }
}
