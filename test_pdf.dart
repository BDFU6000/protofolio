import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

void main() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                children: List.generate(50, (i) => pw.Text('Main Content $i', style: const pw.TextStyle(fontSize: 20))),
              ),
            ),
            pw.Partition(
              width: 188,
              child: pw.Column(
                children: List.generate(20, (i) => pw.Text('Sidebar $i')),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  final file = File('test_output.pdf');
  await file.writeAsBytes(await pdf.save());
  print('PDF generated successfully');
}
