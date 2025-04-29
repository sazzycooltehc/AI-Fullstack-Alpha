import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { Router } from '@angular/router';
import { LoginService } from '../../core/services/login/login.service';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient, HttpHeaders, provideHttpClient } from '@angular/common/http';
import { environment } from '../../../environments/environment.development';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
@Component({
  selector: 'app-normal-login',
  standalone: true,
  imports: [MatCardModule, MatButtonModule, MatFormFieldModule, MatInputModule, ReactiveFormsModule, FormsModule],
  templateUrl: './normal-login.component.html',
  styleUrl: './normal-login.component.scss',
  changeDetection: ChangeDetectionStrategy.OnPush,
})

export class NormalLoginComponent {
  loginForm: FormGroup | any;
  loginError: string = '';
  constructor(private router: Router, private loginAPI: LoginService, private fb: FormBuilder) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
    });
  }
  // Define the properties for the form component

  loginvalue: any;
  hover: boolean = false;
  private http: HttpClient = inject(HttpClient);
  private baseUrl = environment.apiUrl; // Use the environment variable for the base URL


  login() {
    // Implement login logic here
    console.info('Login button clicked!');
    const headers = new HttpHeaders({
      'Content-Type': 'application/x-www-form-urlencoded',
    });


    const body = new URLSearchParams();
    body.set('userid', this.loginForm.value.email);
    body.set('password', this.loginForm.value.password);
    this.http.post(environment.loginUrl, body.toString(), { headers, responseType: 'json' })
      .subscribe({
        next: (response: any) => {
          localStorage.setItem('authToken', response.token); // Save token
          localStorage.setItem('tokenTimestamp', Date.now().toString()); // Save timestamp
          this.router.navigate(['/home']);
          // this.router.navigate(['newsfeed']); // Navigate after login success
        },
        error: (err) => {
          this.loginError = 'Incorrect password or username'; // Set error message
        }
      });
  }
  register() {
    this.router.navigate(['/register']);
    console.info('Register button clicked!');
  }

  logoChange() {
    this.hover = !this.hover;
    console.log('hwllo');
  }
}