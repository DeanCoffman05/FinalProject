import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Restaurant } from 'src/app/models/restaurant';
import { RestaurantService } from 'src/app/services/restaurant.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  restaurantSearchs: Restaurant[] = [];
  restaurantCitySearch: String = new String();
  restaurantstateSearch: String = new String();
  constructor(private restaurantservice: RestaurantService, private router: Router) { }

  ngOnInit() {
  }

  restaurantcitySearch(restaurantCitySearch: String){
    console.log(restaurantCitySearch);
    this.restaurantservice.citySearch(restaurantCitySearch).subscribe({

      next: (restaurantSearchs: Restaurant[]) => {
        console.log(restaurantCitySearch);
        console.log('Received restaurants:', restaurantCitySearch);
        this.restaurantCitySearch = restaurantCitySearch;

      },
      error: (fail) => {console.error('RestaurantComponent.searchByRestaurantCity: error finding restaurant');
      console.error(fail);}
    });
  }
  restaurantStateSearch(restaurantstateSearch: String){
    console.log(restaurantstateSearch);
    this.restaurantservice.stateSearch(restaurantstateSearch).subscribe({

      next: (restaurantSearchs: Restaurant[]) => {
        console.log(restaurantstateSearch);
        console.log('Received restaurants:', restaurantstateSearch);
        this.restaurantstateSearch = restaurantstateSearch;
      },
      error: (fail) => {console.error('RestaurantComponent.searchByRestaurantCity: error finding restaurant');
      console.error(fail);}
    });
  }

}
