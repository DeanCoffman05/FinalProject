import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-updateprofile',
  templateUrl: './updateprofile.component.html',
  styleUrls: ['./updateprofile.component.css']
})
export class UpdateprofileComponent implements OnInit {
  currentUser: User = new User();
  selected: User | null = null;
  editUser: User | null = null;


  constructor(
    private authService: AuthService,
    private userService: UserService,
    private activatedRoute: ActivatedRoute,
    private router: Router
  ) { }


  ngOnInit() {
    this.reload();
    this.authService.getLoggedInUser().subscribe({
      next: (user) => {
        this.currentUser = user;
      },
      error: (err) => {
        console.error('Error loading user: ', err)
      }
    });
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
  updateUser(user: User, setSelected: boolean = true) {
    this.userService.updateUser(user).subscribe({
      next: (updatedUser) => {
        if (setSelected) {
          this.selected = updatedUser;
        }
        this.editUser = null;
        this.reload();
      },
      error: (fail) => {
        console.error('ProfileComponent.updateUser: error updating User');
        console.error(fail);
      },
    });
  }
  onSubmit() {
    this.updateUser(this.currentUser);
}
}
