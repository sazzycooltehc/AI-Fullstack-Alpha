import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { Router } from '@angular/router';
import { LoginService } from '../../core/services/login/login.service';
import { catchError, Observable, throwError } from 'rxjs';
import { HttpClient, provideHttpClient } from '@angular/common/http';
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
  constructor(private router: Router, private loginAPI: LoginService, private fb: FormBuilder) { 
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
    });
  }
  // Define the properties for the form component

  loginvalue: any;
  private http: HttpClient = inject(HttpClient);
  private baseUrl = environment.apiUrl; // Use the environment variable for the base URL

login() {
  // Implement login logic here
  this.router.navigate(['/home']);
  console.info('Login button clicked!');
  return this.http.get<any>(`${this.baseUrl}/login`).pipe(
    catchError((error) => {
      console.error('Error fetching data:', error.message || error);
      return throwError(() => new Error('Failed to fetch data. Please try again later.'));
    })
  );
}
forgot() {
  // Implement forgot password logic here
  console.log('Forgot password button clicked!');
}

}