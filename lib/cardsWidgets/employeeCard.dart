// Mouhana Almouhana
// MouhanaAlmouhana@gmail.com


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './infoField.dart';

class EmployeeCard extends StatefulWidget {
  final List<String> infoRow;
  final List<Function> actionRow;
  const EmployeeCard({super.key, required this.infoRow, required this.actionRow,});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  List<dynamic> _employees = [];
  void fetchEmployees() async{
  const url = "https://65c8f413a4fbc162e1126b21.mockapi.io/employee";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  _employees = jsonDecode(response.body);
  }
  
  
  // final List<Map<String, dynamic>> _employees = List.generate(20, (index) => {
  //   "id": index,
  //   "name": "name of employee $index",
  //   "jobTitle": "Job Title of Employee $index",
  //   "phone": "phone number of employee $index",
  //   "email": "email of employee $index",
  //   "image": "Employee image",
  //   "status": "active or inactive"
  // });

  @override
  Widget build(BuildContext context) {
    fetchEmployees();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: _employees.length,
      itemBuilder: (_, index){
          final employee = _employees[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
            surfaceTintColor: Colors.white,
            elevation: 4,
            child: ExpansionTile(
              shape: const Border(),
              childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              iconColor: Color.fromRGBO(99, 102, 241, 1),
              collapsedIconColor: Color.fromRGBO(99, 102, 241, 1),
              title: Text(employee["name"],style: TextStyle(color: Color.fromRGBO(99, 102, 241, 1)),),
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image(
                        image: NetworkImage(
                          employee["avatar"]
                          ),
                          fit: BoxFit.contain,
                          height: 120,
                          width: 120,
                          ),
                    ),
                              SizedBox(width: 20,),    
                    Column(
                      
                      children: [
                        for(var field in widget.infoRow)...[
                          if (field == "status")...[
                          infoField(data: (employee[field]? "Active": "Inactive")),
                          ]
                          else...[
                          infoField(data: employee[field])
                          ],
                          if(field != widget.infoRow.last)
                          SizedBox(height: 10,),
                        ]
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                      for (var i = 0; i < widget.actionRow.length; i++) ...[
                          Column(
                            children: [widget.actionRow[i](employee)],
                          ),
                          if (i < widget.actionRow.length - 1) SizedBox(width: 20),
                        ],
                  ],
                ),
              ],
              ),
          );
      } 
      );
  }
}




