
import { Address } from "./address";
import { Restaurant } from "./restaurant";
import { Restaurantreview } from "./restaurantreview";
export type RatedRestaurant = { name: string, rating: number};

export class User {
  id: number;
  username: string;
  password: string;
  firstName: String;
  lastName: String;
  email: string;
  role: string;
  enabled: boolean;
  imageUrl: string;
  aboutMe: string;
  address: Address;
  latitude: number;
  longitude: number;
  restaurantReviews: Restaurantreview[];
  favoriteRestaurants: Restaurant[];

  constructor(
    id: number = 0,
    username: string = '',
    password: string = '',
    firstName: String = '',
    lastName: String = '',
    email:  string = '',
    role: string = '',
    enabled: boolean = false,
    imageUrl: string = '',
    aboutMe: string = '',
    address: Address = new Address(),
    latitude: number = 0,
    longitude: number = 0,
    restaurantReviews: Restaurantreview[] = [],
    favoriteRestaurants: Restaurant[] = []
  ){
    this.id = id;
    this.username = username;
    this.password = password;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.role = role;
    this.enabled = enabled;
    this.imageUrl = imageUrl;
    this.aboutMe = aboutMe;
    this.address = address;
    this.latitude = latitude;
    this.longitude = longitude;
    this.restaurantReviews = restaurantReviews;
    this.favoriteRestaurants = favoriteRestaurants;
  }

}
