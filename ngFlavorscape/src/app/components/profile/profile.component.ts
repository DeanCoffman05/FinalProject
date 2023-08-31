import { Component, OnInit } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { Restaurant } from "src/app/models/restaurant";
import { User } from "src/app/models/user";
import { AuthService } from "src/app/services/auth.service";
import { UserService } from "src/app/services/user.service";


@Component({
  selector: 'app-user-list',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  currentUser: User = new User();
  restaurantSearchs: Restaurant[] = [];


  constructor(
    private authService: AuthService,
    private userService: UserService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    this.reload();
  }

  reload() {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        console.log(user);
        this.currentUser = user;
        console.log(user.restaurantReviews);


      },
      error: (err) => {
        console.error('Error loading users:', err);
      }
    });
  }

}
