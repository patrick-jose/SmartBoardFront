import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  login = false;
  title = 'Smart Board';

  loginSucces(loginsStatus: boolean) {
    this.login = loginsStatus;
  }
}
