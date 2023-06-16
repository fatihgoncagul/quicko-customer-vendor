import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {

  final List<String> _categoryTable = ['food','vegetable','coffee','coffee','coffee','coffee','coffee'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
                fontSize: 19
            ),
          ),
          Container(
            height: 40,
            child: Row(children: [
                Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categoryTable.length,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ActionChip(
                          backgroundColor: Colors.yellow.shade900,
                          onPressed: (){},
                          label: Center(
                            child: Text(
                              _categoryTable[index],
                              style: TextStyle(color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                   }
                  ),
                ),
              IconButton(
                  onPressed:(){},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
