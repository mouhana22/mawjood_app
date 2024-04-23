// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/cardWidget.dart';
import '../widgets/infoField.dart';
import '../widgets/imageWidget.dart';

class EmployeeCard extends StatefulWidget {
  final List<String> infoRow;
  final List<Function> actionRow;
  final List<dynamic> employees;
  const EmployeeCard({
    super.key,
    required this.employees,
    required this.infoRow,
    required this.actionRow,
  });

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: widget.employees.length,
        itemBuilder: (_, index) {
          final employee = widget.employees[index];
          return CardWidget(
            cardTitle: employee["name"],
            cardBody: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageWidget(avatarURL: employee["image_URL"]),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      for (var field in widget.infoRow) ...[
                        if (field == "status") ...[
                          InfoField(
                              data: (employee[field] ? "Active" : "Inactive")),
                        ] else ...[
                          InfoField(data: employee[field])
                        ],
                        if (field != widget.infoRow.last)
                          const SizedBox(
                            height: 10,
                          ),
                      ]
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.actionRow.length; i++) ...[
                    Column(
                      children: [widget.actionRow[i](employee)],
                    ),
                    if (i < widget.actionRow.length - 1) const SizedBox(width: 20),
                  ],
                ],
              ),
            ],
          );
        });
  }
}
