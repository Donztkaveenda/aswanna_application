import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/models/user.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_cofig.dart';
import 'expandable_text.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    String sellerUID = product.owner;
    UserDatabaseService userDatabaseService = UserDatabaseService();
    userDatabaseService.getProductOwner(sellerUID);
    String sellerName = UserDatabaseService.name;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                  text: product.title,
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "\n${product.subCategory} ",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ]),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: getProportionateScreenHeight(64),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: Text.rich(
                      TextSpan(
                        text: "\LKR${product.discountPrice}   ",
                        style: TextStyle(
                          color: cPrimaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(
                            text: "\n\LKR${product.originalPrice}",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: cPrimaryColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/Discount.svg",
                          color: cPrimaryColor,
                        ),
                        Center(
                          child: Text(
                            "${product.calculateDiscountPrice()}%\nOff",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenHeight(15),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ExpandableText(
              title: "Highlights",
              content: product.highlights,
            ),
            const SizedBox(height: 16),
            ExpandableText(
              title: "Description",
              content: product.description,
            ),
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: "Sold by ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "${sellerName}",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}