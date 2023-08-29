import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Restaurant } from '../models/restaurant';
import { AuthService } from './auth.service';
import { UserService } from './user.service';
import { Menu } from '../models/menu';
import { MenuItem } from '../models/menu-item';

@Injectable({
  providedIn: 'root'
})
export class MenuService {
  createMenuItem(newMenuItem: any) {
    throw new Error('Method not implemented.');
  }

  private url = environment.baseUrl + "api/restaurants";

  constructor(
    private http: HttpClient,
    private userService: UserService,
    private authService: AuthService
    ) { }

  indexForRestaurant(restaurantId: number): Observable<Menu[]> {
    return this.http.get<Menu[]>(`${this.url}/${restaurantId}/menus`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('MenuService.indexForRestaurant(): error retrieving menus: ' + err)
        );
      })
    );
  }

  // addMenuItem(menuId: number, restaurantId: number): Observable<MenuItem> {
  //   return this.http.post<MenuItem>(this.url, menuId, restaurantId).pipe(
  //     catchError((err: any) => {
  //       console.log(err);
  //       return throwError(
  //         () => new Error('RestaurantService.create(): error creating restaurant: ' + err)
  //       );
  //     })
  //   );
  // }

}
