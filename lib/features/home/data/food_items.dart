import '../domain/models/food_item.dart';

const foodItems = <FoodItem>[
  FoodItem(
    id: 'cheeseburger',
    title: 'Cheeseburger',
    subtitle: "Wendy's Burger",
    rating: 4.9,
    deliveryTime: 26,
    category: 'All',
    imagePath: 'assets/images/cheeseburger.png',
    description:
        "The Cheeseburger Wendy's Burger is a classic fast food burger that packs a punch of flavor in every bite. Made with a juicy beef patty cooked to perfection, it's topped with melted American cheese, crispy lettuce, ripe tomato, and crunchy pickles.",
    price: 8.24,
    initialQuantity: 2,
    initialSpiceLevel: 0.60,
  ),
  FoodItem(
    id: 'veggie',
    title: 'Hamburger',
    subtitle: 'Veggie Burger',
    rating: 4.8,
    deliveryTime: 14,
    category: 'Combos',
    imagePath: 'assets/images/veggie_burger.png',
    description:
        'Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun.',
    price: 9.99,
    initialQuantity: 1,
    initialSpiceLevel: 0.78,
  ),
  FoodItem(
    id: 'chicken',
    title: 'Hamburger',
    subtitle: 'Chicken Burger',
    rating: 4.6,
    deliveryTime: 42,
    category: 'Sliders',
    imagePath: 'assets/images/chicken_burger.png',
    description:
        'Our chicken burger is a delicious and healthier alternative to traditional beef burgers, perfect for those looking for a lighter meal option. Try it today and experience the mouth-watering flavors of our Hamburger Chicken Burger!',
    price: 12.48,
    initialQuantity: 2,
    initialSpiceLevel: 0.36,
  ),
  FoodItem(
    id: 'fried',
    title: 'Fried',
    subtitle: 'Fried Chicken Burger',
    rating: 4.5,
    deliveryTime: 14,
    category: 'Classic',
    imagePath: 'assets/images/fried_chicken_burger.png',
    description:
        'Indulge in our crispy and savory Fried Chicken Burger, made with a juicy chicken patty, hand-breaded and deep-fried to perfection, served on a warm bun with lettuce, tomato, and a creamy sauce.',
    price: 26.99,
    initialQuantity: 4,
    initialSpiceLevel: 0.28,
  ),
];

const categories = <String>[
  'All',
  'Combos',
  'Sliders',
  'Classic',
];
