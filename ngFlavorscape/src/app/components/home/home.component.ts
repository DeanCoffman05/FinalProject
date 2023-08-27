import { Component, OnInit } from '@angular/core';
import { Restaurant } from 'src/app/models/restaurant';
import { RestaurantService } from 'src/app/services/restaurant.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  restaurantSearchs: Restaurant[] = [];
  restaurantsSearch: String = new String();
  constructor(private restaurantservice: RestaurantService) { }

  ngOnInit() {
  }
  restaurantSearch(restaurantCitySearch: String){
    console.log(restaurantCitySearch);
    this.restaurantservice.citySearch(restaurantCitySearch).subscribe({

      next: (restaurantSearchs: Restaurant[]) => {
        console.log(restaurantSearchs);
        console.log('Received restaurants:', restaurantSearchs);
        this.restaurantSearchs = restaurantSearchs;
      },
      error: (fail) => {console.error('RestaurantComponent.searchByRestaurantCity: error finding restaurant');
      console.error(fail);}
    });
  }

}
