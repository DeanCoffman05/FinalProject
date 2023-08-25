import { Component, OnInit } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { User } from "src/app/models/user";
import { UserService } from "src/app/services/userService.service";


@Component({
  selector: 'app-user-list',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit {

  newUser: User = new User();
  selected: User | null = null;
  user: User[] = [];

  constructor(
    private userService: UserService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit() {
    this.reload();

    this.activatedRoute.paramMap.subscribe({
      next: (params) => {
        let userIdStr = params.get("userId");
        if (userIdStr) {
          let userId = Number.parseInt(userIdStr);
          if (isNaN(userId)) {
            this.router.navigateByUrl('invalidUser');
          } else {
            this.userService.show(userId).subscribe({
              next: (user) => {
                this.selected = user;
              },
              error: (err) => {
                console.error('Error loading user:', err);
                this.router.navigateByUrl('/not-found');
              }
            });
          }
        }
      }
    });
  }

  reload() {
    this.userService.index().subscribe({
      next: (userList) => {
        this.user = userList;
      },
      error: (err) => {
        console.error('Error loading users:', err);
      }
    });
  }
}
