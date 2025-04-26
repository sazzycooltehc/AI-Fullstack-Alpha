import { Component } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import {MatButtonModule} from '@angular/material/button';
import { Router } from '@angular/router';

@Component({
  selector: 'app-normal-login',
  standalone: true,
  imports: [MatCardModule, MatButtonModule],
  templateUrl: './normal-login.component.html',
  styleUrl: './normal-login.component.scss'
})
export class NormalLoginComponent {
  constructor(private router: Router) {}

  login() {
    // Implement login logic here
    this.router.navigate(['/home']);
    console.log('Login button clicked!');
  }
  forgot() {
    // Implement forgot password logic here
    console.log('Forgot password button clicked!');
  }

}
