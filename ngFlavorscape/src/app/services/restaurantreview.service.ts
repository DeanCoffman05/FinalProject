import { Injectable } from '@angular/core';
import { Restaurantreview } from '../models/restaurantreview';
import { Observable, catchError, throwError } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { AuthService } from './auth.service';
import { UserService } from './user.service';
import { environment } from 'src/environments/environment';
import { Restaurant } from '../models/restaurant';

@Injectable({
  providedIn: 'root'
})
export class RestaurantreviewService {
  private url = environment.baseUrl + "api/restaurants";

  constructor(private http: HttpClient,
    private userService: UserService,
    private authService: AuthService
  ){}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.authService.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }
  index(): Observable<Restaurantreview[]> {
    return this.http.get<Restaurantreview[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.index(): error retrieving Restaurant: ' + err)
        );
      })
    );
  }

  showRestaurantReviews(restaurantId: number): Observable<Restaurantreview[]> {
    const reviewsUrl = `${this.url}/${restaurantId}/reviews`;
    return this.http.get<Restaurantreview[]>(reviewsUrl, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantReviewService.showRestaurantReviews(): error retrieving reviews: ' + err)
        );
      })
    );
  }

  createRestaurantReview(restaurantReview: Restaurantreview): Observable<Restaurantreview> {
    return this.http.post<Restaurantreview>(this.url, restaurantReview, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('RestaurantService.create(): error creating restaurant: ' + err)
        );
      })
    );
  }
}
