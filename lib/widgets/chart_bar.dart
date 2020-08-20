import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPcOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPcOfTotal);
  //cuando el numero es muy grande se achiva el fittedbox y por lo tanto se
  //se sube la barra del grafico
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                  child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
              ))),
          SizedBox(
            height: constraints.maxHeight * 0.03,
          ),
          Container(
            height: constraints.maxHeight * 0.59,
            width: 14,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColorLight,
                          width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPcOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(height: constraints.maxHeight * 0.12, child: Text(label)),
          /*  SizedBox(
            height: constraints.maxHeight * 0.02,
          ), */
          Container(
            height: constraints.maxHeight * 0.09,
            child: Text('% ${(spendingPcOfTotal * 100).toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
          ),
          /*  Container(
            height: constraints.maxHeight * 0.04,
            child: FittedBox(

                child: Text(
              '% ${(spendingPcOfTotal * 100).toStringAsFixed(0)}',
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
            )),
          ), */
        ],
      );
    });
  }
}
