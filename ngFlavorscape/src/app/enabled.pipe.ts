import { Pipe, PipeTransform } from '@angular/core';
import { Restaurant } from './models/restaurant';

@Pipe({
  name: 'enabled',
})
export class EnabledPipe implements PipeTransform {
  transform(restaurants: Restaurant[], showenabled: boolean): Restaurant[] {
    if (showenabled) {
      return restaurants;
    }
    let results: Restaurant[] = [];

    restaurants.forEach((restaurant)=>{
      if(restaurant.enabled){
        results.push(restaurant)
      }
    })

    return results;
  }
}
