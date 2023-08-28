import { Cuisine } from "./cuisine";
import { Menu } from "./menu";

export class MenuItem {
  id: number;
  itemName: String;
  enabled: boolean;
  itemUrl: string;
  description: string;
  calories: number;
  price: number;
  cuisines: Cuisine [];
  menu: Menu;

  constructor(
    id: number = 0,
    itemName: string = '',
    enabled: boolean = false,
    itemUrl: string = '',
    description: string = '',
    calories: number = 0,
    price: number = 0,
    cuisines: Cuisine [] = [],
    menu: Menu = new Menu()
  ){
    this.id = id;
    this.itemName = itemName;
    this.enabled = enabled;
    this.itemUrl = itemUrl;
    this.description = description;
    this.calories = calories;
    this.price = price;
    this.cuisines = cuisines;
    this.menu = menu;
  }
}
