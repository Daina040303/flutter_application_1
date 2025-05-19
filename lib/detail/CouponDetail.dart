import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/UseCouponPage.dart';

class CouponDetail extends StatelessWidget {

  Function closeAction;
  CouponDetail(this.closeAction);


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Center(
            child: Padding(
          padding: EdgeInsets.all(20),

          //  外枠を表示
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
            //  コンテンツの中身を表示
            child: mainContent(context),
          ),
        )));
  }

  // コンテンツの中身
  Widget mainContent(BuildContext context){
    return Column(
      //  表示するサイズを最小にする
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/c_img.jpg'),
        mainCenterContent(),
        mainBottomContent(),
        mainBottomContent2(context),
      ],
    );
  }

  Widget mainCenterContent(){

    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 80,
      color: Colors.grey,
    );
  }

  Widget mainBottomContent(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            Expanded(
                flex: 2,
                child: ElevatedButton(
                    onPressed: () => {closeAction()},
                    child: Padding(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text("閉じる"),
                        ),
                        padding: EdgeInsets.all(2)),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.red),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(5.0),
                                side: BorderSide(
                                    color: Colors.red)))))),
            Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget mainBottomContent2(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Row(
          children: [
            Spacer(flex: 1),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Usecouponpage()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("このクーポンを使う"),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

}