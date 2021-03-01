import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final bool _isRemoved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Dashboard'),
            elevation: 1.0,
          ),
          SliverFillRemaining(
            child: Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('firstName'),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('lastName'),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: _isRemoved
                                    ? Row(
                                  children: [
                                    Icon(Icons.lock_open),
                                    Text('Release'),
                                  ],
                                )
                                    : Row(
                                  children: [
                                    Icon(Icons.lock),
                                    Text(
                                      'Suspend',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
