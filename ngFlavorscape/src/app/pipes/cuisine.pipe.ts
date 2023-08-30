import { Restaurant } from 'src/app/models/restaurant';
import { Cuisine } from './../models/cuisine';
import { Pipe, PipeTransform } from '@angular/core';


@Pipe({
  name: 'cuisine'
})
export class CuisinePipe implements PipeTransform {

  transform(restaurants: Restaurant[], cuisineType: String = 'All'): Restaurant[] {
    console.log(restaurants);
    if(cuisineType === 'All') {
      return restaurants;
    }
    let results:Restaurant[] = [];
   LOOP:for(let restaurant of restaurants) {
    for( let menu of restaurant.menus) {
      for(let menuItem of menu.menuItems) {
        for( let cuisine of menuItem.cuisines) {
          if (cuisine.type === cuisineType) {
            results.push(restaurant);
            continue LOOP;
          }
        }
      }
    }
   }
    return results;
  }

}
