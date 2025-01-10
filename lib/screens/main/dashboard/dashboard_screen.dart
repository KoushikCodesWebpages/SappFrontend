import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import './components/header.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(
              width: defaultPadding,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    height: 500,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(228, 157, 185, 255),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "School Student Fees Due",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(sections: [
                              PieChartSectionData(
                                title: "12th",
                                value: 25,
                                color: const Color.fromARGB(205, 126, 74, 246),
                                radius: 40,
                              ),
                              PieChartSectionData(
                                title: "11th",
                                value: 25,
                                color: const Color.fromARGB(213, 79, 125, 242),
                                radius: 40,
                              ),
                              PieChartSectionData(
                                title: "10th",
                                value: 25,
                                color: const Color.fromARGB(122, 103, 43, 242),
                                radius: 40,
                              ),
                              PieChartSectionData(
                                title: "9th",
                                value: 25,
                                color: const Color.fromARGB(148, 117, 155, 252),
                                radius: 40,
                              ),
                            ]),
                          ),
                        ),
                        // Added second pie chart below the first one
                        Text(
                          "School Student Fees Due",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(sections: [
                              PieChartSectionData(
                                title: "Present",
                                value: 70,
                                color: const Color.fromARGB(213, 79, 125, 242),
                                radius: 40,
                              ),
                              PieChartSectionData(
                                title: "Absent",
                                value: 30,
                                color: const Color.fromARGB(122, 103, 43, 242),
                                radius: 40,
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
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
