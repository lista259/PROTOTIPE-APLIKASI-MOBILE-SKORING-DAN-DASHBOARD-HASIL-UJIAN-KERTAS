import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// ================== MODEL DATA ==================
class Siswa {
  final String nama;
  final int nilai;

  Siswa({required this.nama, required this.nilai});
}

class Soal {
  final int nomor;
  final int jumlahSalah;

  Soal({required this.nomor, required this.jumlahSalah});
}

// ================== DASHBOARD MATEMATIKA ==================
class DashboardMatematika extends StatelessWidget {
  DashboardMatematika({Key? key}) : super(key: key);

  // Contoh data siswa (40 siswa)
  final List<Siswa> siswa = List.generate(
    40,
        (index) => Siswa(
      nama: "Siswa ${index + 1}",
      nilai: (50 + (index * 7) % 51), // random nilai antara 50-100
    ),
  );

  // Contoh data jumlah salah per soal (10 soal)
  final List<Soal> soal = List.generate(
    10,
        (index) => Soal(
      nomor: index + 1,
      jumlahSalah: (5 + (index * 7) % 40), // random antara 5 - 40 salah
    ),
  );

  // Kategori nilai siswa
  String kategoriNilai(int nilai) {
    if (nilai < 70) {
      return "Remedial";
    } else if (nilai < 85) {
      return "Sedang";
    } else {
      return "Unggul";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Urutkan siswa dari nilai tertinggi
    siswa.sort((a, b) => b.nilai.compareTo(a.nilai));

    // Hitung jumlah kategori
    int remedial = siswa.where((s) => s.nilai < 70).length;
    int sedang = siswa.where((s) => s.nilai >= 70 && s.nilai < 85).length;
    int unggul = siswa.where((s) => s.nilai >= 85).length;

    int maxSalah = soal.map((s) => s.jumlahSalah).reduce((a, b) => a > b ? a : b);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================== PIE CHART ==================
            const Text(
              "Kategori Siswa",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: remedial.toDouble(),
                      color: Colors.red,
                      title: "Remedial\n$remedial",
                    ),
                    PieChartSectionData(
                      value: sedang.toDouble(),
                      color: Colors.orange,
                      title: "Sedang\n$sedang",
                    ),
                    PieChartSectionData(
                      value: unggul.toDouble(),
                      color: Colors.green,
                      title: "Unggul\n$unggul",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ================== RANKING SISWA ==================
            const Text(
              "Ranking Siswa (Tertinggi → Terendah)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: siswa.length,
              itemBuilder: (context, index) {
                final s = siswa[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("${index + 1}"),
                  ),
                  title: Text(s.nama),
                  subtitle: Text("Nilai: ${s.nilai} | ${kategoriNilai(s.nilai)}"),
                  trailing: Icon(
                    s.nilai >= 85
                        ? Icons.star
                        : s.nilai >= 70
                        ? Icons.check_circle
                        : Icons.warning,
                    color: s.nilai >= 85
                        ? Colors.green
                        : s.nilai >= 70
                        ? Colors.orange
                        : Colors.red,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // ================== DISTRIBUSI SOAL ==================
            const Text(
              "Distribusi Kesalahan per Nomor Soal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxSalah.toDouble() + 5,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 1 && value.toInt() <= soal.length) {
                            return Text("No ${value.toInt()}");
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  barGroups: soal.map((s) {
                    return BarChartGroupData(
                      x: s.nomor,
                      barRods: [
                        BarChartRodData(
                          toY: s.jumlahSalah.toDouble(),
                          color: Colors.red,
                          width: 18,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ================== TABEL RINGKAS ==================
            const Text(
              "Ringkasan Jumlah Siswa Salah per Soal",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Nomor Soal",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Jumlah Salah",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                ...soal.map((s) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Soal ${s.nomor}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${s.jumlahSalah} siswa"),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
