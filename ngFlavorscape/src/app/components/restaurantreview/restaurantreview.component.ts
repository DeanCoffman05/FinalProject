import { Restaurant } from 'src/app/models/restaurant';
import { Component, OnInit } from '@angular/core';
import { Restaurantreview } from 'src/app/models/restaurantreview';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { RestaurantreviewService } from 'src/app/services/restaurantreview.service';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-restaurantreview',
  templateUrl: './restaurantreview.component.html',
  styleUrls: ['./restaurantreview.component.css']
})
export class RestaurantreviewComponent implements OnInit {
  restaurantreviews: Restaurantreview[] = [];
  currentUser: User = new User();
  newRestaurantReview: Restaurantreview = new Restaurantreview();
  editRestaurant: Restaurant | null = null;
  selected: Restaurant | null = null;

  constructor(
    private authService: AuthService,
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private restaurantreviewService: RestaurantreviewService
  ) { }

  ngOnInit() {
    this.reload();
  }

  reload() {
    this.restaurantreviewService.index().subscribe({
      next: (restaurantreviews: Restaurantreview[]) => {
        console.log('Received restaurants:', restaurantreviews);
        this.restaurantreviews = restaurantreviews;
      },
      error: (fail) => {
        console.error('RestaurantService.reload(): error getting restaurants');
        console.error(fail);
      },
    });
  }

  loggedInUser() {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.currentUser = user;
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.loggedInUser: error updating restaurant'
        );
        console.error(fail);
      },
    });
  }

  addRestaurantReview(newRestaurantReview: Restaurantreview) {
    newRestaurantReview.id = this.newRestaurantReview.id;
    this.loggedInUser();
    this.restaurantreviewService.createRestaurantReview(newRestaurantReview).subscribe({
      next: () => {
        this.newRestaurantReview = new Restaurantreview();
        this.reload();
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.createRestaurant: error updating restaurant'
        );
        console.error(fail);
      },
    });
  }
}
