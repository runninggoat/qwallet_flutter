import 'package:flutter/material.dart';

class TokenList extends StatelessWidget {
  List<Map> _tokens = List();

  TokenList(List<Map> tokens) {
    _tokens.addAll(tokens);
  }

  @override
  Widget build(BuildContext context) {
    // print('$_tokens');
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _tokens.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (BuildContext ctx, int idx) {
        // return Text(_tokens[idx]['name']);
        return Container(
          padding: EdgeInsets.only(left: 15),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 15, 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide( color: Color(0xFF999999) ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Image.asset('lib/assets/images/iconETH.png', width: 40, height: 40,),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          _tokens[idx]['name'],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(_tokens[idx]['amount'].toString(), textAlign: TextAlign.right,),
                  flex: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
}
