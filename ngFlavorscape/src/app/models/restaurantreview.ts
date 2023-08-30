export class Restaurantreview {

  id: number;
  atmosphere: String;
  enabled: boolean;
  imageUrl: string;
  smell: string;
  service: string;
  price: string;
  food: string;
  rating: number;
  userId: number;
  restaurantId: number;

  constructor(
    id: number = 0,
    atmosphere: string = '',
    enabled: boolean = false,
    imageUrl: string = '',
    smell: string = '',
    service: string = '',
    price: string = '',
    food: string = '',
    rating: number = 0,
    userId: number = 0,
    restaurantId: number = 0
  ){
    this.id = id;
    this.atmosphere = atmosphere;
    this.enabled = enabled;
    this.imageUrl = imageUrl;
    this.smell = smell;
    this.service = service;
    this.price = price;
    this.food = food;
    this.rating = rating;
    this.userId = userId;
    this.restaurantId = restaurantId;
  }

}
