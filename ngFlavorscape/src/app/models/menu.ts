import { MenuItem } from "./menu-item";

export class Menu {

  id: number;
  type: string;
  enabled: boolean;
  description: string;
  menuItems: MenuItem [];


  constructor(
    id: number = 0,
    type: string = '',
    enabled: boolean = false,
    description: string = '',
    menuItems: MenuItem [] = []
  ){
    this.id = id;
    this.type = type;
    this.enabled = enabled;
    this.description = description;
    this.menuItems = menuItems;
  }
}
