export class Cuisine {
  id: number;
  type: String;
  iconUrl: string;
  description: string;

  constructor(
    id: number = 0,
    type: string = '',
    iconUrl: string = '',
    description: string = ''
  ){
    this.id = id;
    this.type = type;
    this.iconUrl = iconUrl;
    this.description = description;
  }
}
