import { Component, OnInit } from '@angular/core';
import { OktaAuthService } from '@okta/okta-angular';
import {Router} from '@angular/router';

@Component({
  selector: 'app-login-status',
  templateUrl: './login-status.component.html',
  styleUrls: ['./login-status.component.css']
})
export class LoginStatusComponent implements OnInit {

  isAuthenticated = false;
  userFullName: string;
  storage: Storage = sessionStorage;

  constructor(private authStateService: OktaAuthService, private router: Router) { }

  ngOnInit(): void {

    // Subscribe to authentication stage change
    this.authStateService.$authenticationState.subscribe((result) => {
      this.isAuthenticated = result;
      this.getUserDetails();
    });
  }

  getUserDetails(): void {
    if (this.isAuthenticated) {
      // Fetch the logged user details (user's claims)
      this.authStateService.getUser().then((res) => {
        this.userFullName = res.name;

        // retrieve the user's email
        const theEmail = res.email;

        // now store the email in browser storage
        this.storage.setItem('userEmail', JSON.stringify(theEmail));
      });
    }
  }

 logout(): void {
    // Terminates the session with okta and removes current tokens
    this.authStateService.signOut();
  }

  async login(): Promise<void> {
    await this.authStateService.signInWithRedirect();
  }
}
