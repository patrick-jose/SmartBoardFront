import { Component, Inject, Input, OnInit } from '@angular/core';
import { Section } from '../classes/section';
import { Task } from '../classes/task';
import { User } from '../classes/user';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MyDataService } from '../services/my-data.service';
import { StatusHistory } from "../classes/statusHistory";

export interface DialogData {
  newStatus: Section;
  newTask: Task;
  task: Task;
  sections: Section[];
  users: Array<User>;
}

@Component({
  selector: 'tasks-section-new-status.component.dialog',
  templateUrl: 'tasks-section-new-status.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionNewStatusComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionNewStatusComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, 
    ) {}

  onNoClick(): void {
    this.dialogRef.close(false);
  }
}

@Component({
  selector: 'tasks-section-new-task.component.dialog',
  templateUrl: 'tasks-section-new-task.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionNewTaskComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionNewTaskComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, 
    ) {}

  onNoClick(): void {
    this.dialogRef.close(false);
  }

  setBlocked(){
    this.data.newTask.blocked = !this.data.newTask.blocked
  }
}

@Component({
  selector: 'tasks-section-task-details.component.dialog',
  templateUrl: 'tasks-section-task-details.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionTaskDetailsComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionTaskDetailsComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
    private myDataService: MyDataService 
    ) {}

  onNoClick(): void {
    this.dialogRef.close(false);
  }

  ngOnInit(): void {
    this.myDataService.getAllUsers().subscribe((data) => {
      this.data.users = data;
    });
  }

  editEnabled = false;

  editTask(){
    this.editEnabled = !this.editEnabled;
  }
}

@Component({
  selector: 'app-tasks-section',
  templateUrl: './tasks-section.component.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionComponent implements OnInit {
  sections : Array<Section> = [];

  constructor(public dialog: MatDialog, private myDataService: MyDataService) {
    sections : Array<Section>;
  }

  ngOnInit(): void {
    this.myDataService.getAllSectionsByBoardId(this.boardId).subscribe((data) => {
      this.sections = data;
      this.loadTasks(this.sections);
    });
  }

  loadTasks(sections : Array<Section>) {
    sections.forEach(section => {
      this.myDataService.getAllTasksBySectionId(section.id).subscribe((data) => {
        section.tasks = data;

        section.tasks.forEach(task => {
          this.loadComments(task);
          this.loadAssignee(task);
          this.loadStatusHistory(task, sections);
        });

        this.loadSection(section.tasks, section);
      })
    });
  };

  loadSection(tasks : Array<Task>, section : Section) {
    tasks.forEach(task => {
        task.section = section.name;
    });
  }

  loadComments(task : Task) {
    this.myDataService.getAllCommentsByTaskId(task.id).subscribe((data) => {
      task.comments = data;
    });
  };

  loadAssignee(task : Task) {
    if (task.assigneeId != undefined && task.assigneeId > 0)
      this.myDataService.getUserById(task.assigneeId).subscribe((data) => {
        task.assignee = data;
      })
    else
    {
      task.assignee = this.emptyUser;
      task.assignee.name = 'Unassigned'
    }
  };

  loadStatusHistory(task : Task, sections: Array<Section>) {
    this.myDataService.getStatusHistoryByTaskId(task.id).subscribe((data) => {
      data.forEach(d => {
        d.actualSectionName = sections.find(s => s.id = d.actualSectionId)?.name;
        d.previousSectionName = sections.find(s => s.id = d.previousSectionId)?.name;
      });
      task.history = data;
    });
  };

  @Input() user: User = {
    name: '',
    password: '',
    login: false,
    id: 0
  };
  @Input() editClicked = false;
  @Input() boardId = 1;
  newStatusName = '';
  
  emptyUser: User = {
    name: '',
    password: '',
    login: false,
    id: 0
  };

  newTask: Task = {
    name: '',
    position: 1,
    description: '',
    lastModified: new Date(),
    comments: [],
    blocked: false,
    history: [],
    assigneeId: 0,
    section: '',
    creatorName: this.user.name,
    creatorId: this.user.id,
    id: 0,
    dateCreation: new Date(),
    sectionId: 0,
    active: false,
    assignee: this.emptyUser
  };

  openNewStatusDialog(): void {
    const dialogRef = this.dialog.open(TasksSectionNewStatusComponentDialog, {
      data: { newStatusName: this.newStatusName },
    });
    
    dialogRef.afterClosed().subscribe(result => {
      if (result != false && result != '' && result != undefined)
      {
        this.newStatusName = result;
        this.addTab(this.newStatusName, 1);
      }
      this.newStatusName = '';
    });
  }

  openNewTaskDialog(section: Section): void { 
    let statushistory : StatusHistory = {
      userId: this.user.id,
      previousSectionId: 0,
      actualSectionId: 0,
      dateModified: new Date(),
      taskId: 0,
      previousSectionName: section.name,
      actualSectionName: section.name
    };

    this.newTask.section = section.name;
    this.newTask.creatorName = this.user.name;
    this.newTask.description = '';
    this.newTask.history.push(statushistory);
    this.newTask.blocked = false;

    const dialogRef = this.dialog.open(TasksSectionNewTaskComponentDialog, {
      data: { newTask: this.newTask },
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result != false && this.newTask.name != '')
        this.addTask(section, result);
      this.newTask.name = '';
      this.newTask.history.pop();
    });
  }

  openTaskDetailsDialog(task: Task): void {
    const dialogRef = this.dialog.open(TasksSectionTaskDetailsComponentDialog, {
      data: { task: task, sections: this.sections },
    });
  }

  addTab(name: string, position: number) {
    let newSection: Section = {
      name: name,
      position: position,
      active: true,
      id: 1,
      boardId: 1,
      tasks: new Array<Task>
    };

    this.sections.push(newSection);
  }

  removeTab(index: number) {
    this.sections.splice(index, 1);
  }

  addTask(section: Section, task: Task) {
    let newTask: Task = {
      name: task.name,
      position: 1,
      description: task.description,
      lastModified: task.lastModified,
      comments: task.comments,
      blocked: task.blocked,
      history: task.history,
      assigneeId: task.assigneeId,
      section: task.section,
      creatorId: task.creatorId,
      id: task.id,
      dateCreation: task.dateCreation,
      sectionId: task.sectionId,
      active: task.active,
      creatorName: task.creatorName,
      assignee: task.assignee
    };

    if (section.tasks.length != 0) {
      newTask.position = section.tasks[section.tasks.length-1].position + 1;
    }

    section.tasks.push(newTask);
  }

  openTaskDetails(task: Task) {
    this.openTaskDetailsDialog(task);
  }
}
