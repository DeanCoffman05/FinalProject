import { Address } from 'src/app/models/address';
import { AuthService } from './../../services/auth.service';
import { RestaurantService } from './../../services/restaurant.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Restaurant } from 'src/app/models/restaurant';
import { User } from 'src/app/models/user';
import { MenuService } from 'src/app/services/menu.service';
import { Menu } from 'src/app/models/menu';
import { MenuItem } from 'src/app/models/menu-item';
import { EnabledPipe } from 'src/app/enabled.pipe';
import { Restaurantreview } from 'src/app/models/restaurantreview';
import { RestaurantreviewService } from 'src/app/services/restaurantreview.service';


@Component({
  selector: 'app-restaurant',
  templateUrl: './restaurant.component.html',
  styleUrls: ['./restaurant.component.css'],
})
export class RestaurantComponent implements OnInit {
  restaurants: Restaurant[] = [];
  restaurantSearchs: Restaurant[] = [];
  newRestaurant: Restaurant = new Restaurant();
  editRestaurant: Restaurant | null = null;
  selected: Restaurant | null = null;
  currentUser: User = new User();
  address: Address = new Address();
  menus: Menu[] = [];
  newMenuItem: MenuItem = new MenuItem();
  reviews: Restaurantreview [] = [];
  newRestaurantReview: Restaurantreview = new Restaurantreview();



  showEnabled: boolean = false;
  selectedValue: number = 0;
  hoverValue: number = 0;
  stars: number[] = [1, 2, 3, 4, 5];




  constructor(
    private restaurantService: RestaurantService,
    private authService: AuthService,
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private menuService: MenuService,
    private showenabled: EnabledPipe,
    private restaurantreviewService: RestaurantreviewService

  ) {}

  ngOnInit() {
    console.log('RestaurantComponent initialized.');
    this.reload();
  }

  reload() {
    this.restaurantService.index().subscribe({
      next: (restaurants: Restaurant[]) => {
        console.log('Received restaurants:', restaurants);
        this.restaurants = restaurants;
      },
      error: (fail) => {
        console.error('RestaurantService.reload(): error getting restaurants');
        console.error(fail);
      },
    });
  }
  countStar(star: number) {
    this.hoverValue = star;
}

removeStar(star: number) {
    this.hoverValue = 0;
}


setRatingForRestaurantReview(reviewId: number, star: number) {
    this.selectedValue = star;

    this.restaurantService.rateRestaurant(reviewId, star).subscribe({
        next: () => {
            console.log('Rating saved successfully');
        },
        error: (error) => {
            console.error('Error saving rating:', error);
        }
    });
}


  displayRestaurant(restaurant: any) {
    this.selected = restaurant;
    this.getRestaurantMenus();
    this.showReviews(restaurant.id);
  }
  displayList() {
    this.selected = null;
  }
  setEditRestaurant() {
    this.editRestaurant = Object.assign({}, this.selected);
  }
  updateRestaurant(updatedRestaurant: Restaurant, setSelected: boolean = true) {
    this.loggedInUser();
    this.restaurantService.updateRestaurant(updatedRestaurant).subscribe({
      next: (updateRestaurant) => {
        if (setSelected) {
          this.selected = updateRestaurant;
        }
        this.editRestaurant = null;
        this.reload();
      },
      error: (fail) => {
        console.error(
          'RestaurantComponent.updateRestaurant: error updating restaurant'
        );
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

  addRestaurant(newResta: Restaurant) {
    newResta.address = this.address;
    this.loggedInUser();
    this.restaurantService.create(newResta).subscribe({
      next: () => {
        this.newRestaurant = new Restaurant();
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

  getCurrentRole() {
    return this.authService.getCurrentRole();
  }

  getRestaurantMenus() {
    if (this.selected) {
      this.menuService.indexForRestaurant(this.selected?.id).subscribe({
        next: (menus: Menu[]) => {
          console.log('Received menus:', menus);
          this.menus = menus;
        },
        error: (fail) => {
          console.error('RestauService.reload(): error getting restaurants');
          console.error(fail);
        },
      });
    }
  }

  loggedIn(): boolean {
    return this.authService.checkLogin();
  }
  deleteRestaurant(restaurantId: number) {
    this.loggedInUser();
    this.restaurantService.deleteRestaurant(restaurantId).subscribe({
      next: () => {
        this.displayList();
        this.reload();
      },
      error: (fail) => {
        console.error(
          'RestauService.deleteRestaurant(): error deleting restaurants'
        );
        console.error(fail);
      },
    });
  }

  showReviews(restaurantId: number) {
    this.restaurantreviewService.showRestaurantReviews(restaurantId).subscribe({
      next: (reviews: Restaurantreview[]) => {
        console.log('Received reviews:', reviews);
        this.reviews = reviews;
      },
      error: (fail) => {
        console.error('RestaurantreviewService.showRestaurantReviews(): error getting reviews');
        console.error(fail);
      },
    });
  }

  addRestaurantReview(newRestaurantReview: Restaurantreview, restaurantId: number) {
    this.loggedInUser();
    this.restaurantreviewService.createRestaurantReview(newRestaurantReview, restaurantId).subscribe({
      next: () => {
        this.newRestaurantReview = new Restaurantreview();
        this.showReviews(restaurantId);
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

