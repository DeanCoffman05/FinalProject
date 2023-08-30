import { Injectable } from '@angular/core';
import { Restaurantreview } from '../models/restaurantreview';
import { Observable, catchError, throwError } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { AuthService } from './auth.service';
import { UserService } from './user.service';
import { environment } from 'src/environments/environment';

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
}
