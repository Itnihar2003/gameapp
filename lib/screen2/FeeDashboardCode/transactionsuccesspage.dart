import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class SuccessScreen extends StatelessWidget {
  final String studentName;
  final String batchName;
  final String dateOfTransaction;
  final String phoneNumber;
  final String amount; // Paid Amount
  final String remark;
  final String balance; // Newly Added Balance Amount

  const SuccessScreen({
    Key? key,
    required this.studentName,
    required this.batchName,
    required this.dateOfTransaction,
    required this.phoneNumber,
    required this.amount,
    required this.remark,
    required this.balance,
  }) : super(key: key);

  // Generate PDF
  Future<pw.Document> _generatePdf() async {
    final pw.Document pdf = pw.Document();
    final ByteData imageData = await rootBundle.load('assets/u15.png');
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    // Load the custom font
    final ByteData fontData = await rootBundle.load('assets/Roboto/Roboto-Italic-VariableFont_wdth,wght.ttf');
    final pw.Font customFont = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => pw.Container(
          padding: const pw.EdgeInsets.all(16),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Invoice',
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Your Organization',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Image(
                    pw.MemoryImage(imageBytes), // Add the image here
                    width: 100, // Adjust width as needed
                    height: 100, // Adjust height as needed
                  ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                _buildTableRow('Student Name', studentName, customFont),
                _buildTableRow('Batch Name', batchName, customFont),
                _buildTableRow('Date of Transaction', dateOfTransaction, customFont),
                _buildTableRow('Phone Number', phoneNumber, customFont),
                _buildTableRow('Paid Amount', '₹$amount', customFont),
                _buildTableRow('Balance Amount', '₹$balance', customFont), // New Row
                _buildTableRow('Remark', remark, customFont),
              ],
              ),
              pw.SizedBox(height: 40),
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Authorized Signature',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontStyle: pw.FontStyle.italic,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Container(
                      width: 120,
                      height: 40,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return pdf;
  }

  pw.TableRow _buildTableRow(String parameter, String value, pw.Font font) {
  return pw.TableRow(
    children: [
      pw.Padding(
        padding: const pw.EdgeInsets.all(8.0),
        child: pw.Text(parameter,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: font)),
      ),
      pw.Padding(
        padding: const pw.EdgeInsets.all(8.0),
        child: pw.Text(value, style: pw.TextStyle(font: font)),
      ),
    ],
  );
}


  // Save PDF
  Future<String> _savePdfToDownloads(pw.Document pdf) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final Directory? directory = await getExternalStorageDirectory();
      final String downloadsPath =
          '${directory?.parent.parent.parent.parent.path}/Download';
      final String filePath = '$downloadsPath/transaction_receipt.pdf';
      final File file = File(filePath);

      await file.writeAsBytes(await pdf.save());

      print('PDF saved at $filePath');
      return filePath;
    } else {
      throw 'Permission denied';
    }
  }

  // Download PDF
  Future<void> _downloadPdf(BuildContext context) async {
    try {
      final pdf = await _generatePdf();
      final filePath = await _savePdfToDownloads(pdf);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved at $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PDF: $e')),
      );
    }
  }

  // Share PDF
  Future<void> _sharePdf() async {
    final pdf = await _generatePdf();
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'transaction_receipt.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              "Payment Successfully Added!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "₹$amount", // Displays the entered amount
              style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              "₹$amount received from $studentName",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _downloadPdf(context);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/u9.png'),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    _sharePdf();
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/u10.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
