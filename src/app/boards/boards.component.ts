import { Component, Input, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { User } from '../classes/user';
import { Board } from '../classes/board';
import { MyDataService } from '../services/my-data.service';

@Component({
  selector: 'app-boards',
  templateUrl: './boards.component.html',
  styleUrls: ['./boards.component.css']
})
export class BoardsComponent implements OnInit {
  tabs : any;

  constructor(private myDataService: MyDataService) {
    tabs : Array<Board>;
  }

  ngOnInit(): void {
    this.myDataService.getBoards().subscribe((data) => {
      this.tabs = data;
    });
  }

  selected = new FormControl(0);
  editClicked = false;
  
  @Input() user: User = {
    name: '',
    password: '',
    login: false,
    id: 0
  };

  addTab() {
    this.tabs.push('Board ' + (this.tabs.length + 1));
    this.selected.setValue(this.tabs.length - 1);
  }

  removeTab(index: number) {
    this.tabs.splice(index, 1);
  }
}