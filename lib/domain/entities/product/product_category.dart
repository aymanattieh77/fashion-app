import 'package:fashion_app/core/utils/strings.dart';

abstract class MenCategory {
  static const shirts = 3136;
  static const shorts = 5231;
  static const suitsAndTailoring = 8134;
  static const tShirtsAndTankTops = 5232;
  static const shoesAndSneakers = 1935;

  static final List<Category> categories = [
    Category(
        categoryName: AppStrings.tShirts,
        categoryId: shirts,
        image:
            'https://images.asos-media.com/products/aeropostale-stripe-shirt-in-light-pink/204443121-1-pink'),
    Category(
      categoryName: AppStrings.suitsAndTailoring,
      categoryId: suitsAndTailoring,
      image:
          'https://images.asos-media.com/products/french-connection-slim-fit-plain-suit-jacket/202183978-1-black',
    ),
    Category(
      categoryName: AppStrings.tShirtsAndTankTops,
      categoryId: tShirtsAndTankTops,
      image:
          'https://images.asos-media.com/products/le-breve-tank-top-in-white/204130089-1-white',
    ),
    Category(
      categoryName: AppStrings.shorts,
      categoryId: shorts,
      image:
          'https://images.asos-media.com/products/le-breve-denim-cargo-shorts-in-mid-blue/204130192-1-blue',
    ),
    Category(
      categoryName: AppStrings.shoesAndSneakers,
      categoryId: shoesAndSneakers,
      image:
          'https://images.asos-media.com/products/ben-sherman-boat-shoes-in-sand/204117658-1-sand',
    ),
  ];
}

abstract class WomenCategory {
  static const dresses = 5235;
  static const tops = 4167;
  static const jeans = 4331;
  static const shoes = 1931;
  static final List<Category> categories = [
    Category(
      categoryName: AppStrings.dresses,
      categoryId: dresses,
      image:
          'https://images.asos-media.com/products/tfnc-bridesmaid-one-shoulder-maxi-dress-in-teracotta/204329344-1-teracotta',
    ),
    Category(
      categoryName: AppStrings.jeans,
      categoryId: jeans,
      image:
          'https://images.asos-media.com/products/parisian-tall-skinny-jeans-in-indigo/21643306-1-indigo',
    ),
    Category(
      categoryName: AppStrings.shoes,
      categoryId: shoes,
      image:
          'https://images.asos-media.com/products/london-rebel-flare-heeled-platform-sandals-in-light-pink/203826478-1-lightpink',
    ),
    Category(
      categoryName: AppStrings.tops,
      categoryId: tops,
      image:
          'https://images.asos-media.com/products/pieces-long-sleeve-top-with-button-detail-in-beige/203561630-1-falcon',
    ),
  ];
}

abstract class AllProdcutCategories {
  static final categories = [
    Category(
      categoryName: AppStrings.mensTShirts,
      categoryId: MenCategory.shirts,
    ),
    Category(
      categoryName: AppStrings.mensSuitsAndTailoring,
      categoryId: MenCategory.suitsAndTailoring,
    ),
    Category(
      categoryName: AppStrings.womenDresses,
      categoryId: WomenCategory.dresses,
    ),
    Category(
      categoryName: AppStrings.womenJeans,
      categoryId: WomenCategory.jeans,
    ),
    Category(
      categoryName: AppStrings.menTShritsAndTops,
      categoryId: MenCategory.tShirtsAndTankTops,
    ),
    Category(
      categoryName: AppStrings.womenTops,
      categoryId: WomenCategory.tops,
    ),
    Category(
      categoryName: AppStrings.menShorts,
      categoryId: MenCategory.shorts,
    ),
    Category(
      categoryName: AppStrings.menShoseAndSneakers,
      categoryId: MenCategory.shoesAndSneakers,
    ),
    Category(
      categoryName: AppStrings.womenShoes,
      categoryId: WomenCategory.shoes,
    ),
  ];
}

class Category {
  String categoryName;
  int categoryId;
  String? image;
  Category({
    required this.categoryName,
    required this.categoryId,
    this.image,
  });
}
