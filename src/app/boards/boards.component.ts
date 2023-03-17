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
    let newTab : Board = {
      id: 0,
      name: 'Board ' + (this.tabs.length + 1),
      active: true
    }; 

    this.tabs.push(newTab);

    function selectNewBoard(tabs: Array<Board>, selected : FormControl) {
        selected.setValue(tabs.length - 1);
        console.log("2");
      }
      function postNewBoard(service: MyDataService) {
        service.postBoard(newTab).subscribe();
        console.log("1");
      }
      function updateTabs(service: MyDataService, tabs: Array<Board>) {
        service.getBoards().subscribe((data) => {
          tabs = data;
          console.log("3");
        });
      }

      setTimeout((tabs : Array<Board> = this.tabs, selected : FormControl = this.selected) => {
        selectNewBoard(tabs, selected);
      }, 500);
      postNewBoard(this.myDataService);
      updateTabs(this.myDataService, this.tabs);
  }

  removeTab(index: number) {
    this.tabs.splice(index, 1);
  }
}