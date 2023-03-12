import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  login = false;

  @Output() loginSucessEvent = new EventEmitter<boolean>();

  changeLoginStatus() {
    this.loginSucessEvent.emit(this.login);
  }
}
