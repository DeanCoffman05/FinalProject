import { Component, OnInit } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
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



  constructor(
    private authService: AuthService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    this.reload();

    // this.activatedRoute.paramMap.subscribe({
    //   next: (params) => {
    //     let userIdStr = params.get("userId");
    //     if (userIdStr) {
    //       let userId = Number.parseInt(userIdStr);
    //       if (isNaN(userId)) {
    //         this.router.navigateByUrl('invalidUser');
    //       } else {
    //         this.userService.show(userId).subscribe({
    //           next: (user) => {
    //             this.selected = user;
    //           },
    //           error: (err) => {
    //             console.error('Error loading user:', err);
    //             this.router.navigateByUrl('/not-found');
    //           }
    //         });
    //       }
    //     }
    //   }
    // });
  }

  reload() {
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.currentUser = user;
      },
      error: (err) => {
        console.error('Error loading users:', err);
      }
    });
  }
}
