import { Component, forwardRef, Inject, Input, OnInit } from '@angular/core';
import { Section, SectionDTO } from '../classes/section';
import { Task, TaskDTO } from '../classes/task';
import { User } from '../classes/user';
import { UserDTO } from '../classes/user';
import { CommentDTO } from '../classes/commentDTO';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MyDataService } from '../services/my-data.service';
import { StatusHistory } from "../classes/statusHistory";
import { NG_VALUE_ACCESSOR } from '@angular/forms';

export interface DialogData {
  newStatus: Section;
  newTask: Task;
  newTaskDTO: TaskDTO;
  task: Task;
  sections: Section[];
  users: Array<UserDTO>;
  newComment: CommentDTO;
  user: User;
  section: Section;
  loading: boolean;
}

@Component({
  selector: 'tasks-section-new-status.component.dialog',
  templateUrl: '../task/tasks-section-new-status.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionNewStatusComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionNewStatusComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData, 
    ) {}

  newStatusName = '';

  onNoClick(): void {
    this.dialogRef.close(false);
  }
}

@Component({
  selector: 'tasks-section-new-task.component.dialog',
  templateUrl: '../task/tasks-section-new-task.component.dialog.html',
  styleUrls: ['./tasks-section.component.css']
})
export class TasksSectionNewTaskComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionNewTaskComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
    private myDataService: MyDataService 
    ) {}

  onNoClick(): void {
    this.dialogRef.close(false);
  }

  setBlocked(){
    this.data.newTask.blocked = !this.data.newTask.blocked
  }

  ngOnInit(): void {
    this.data.newTaskDTO = {
      id: 0,
      creatorId: this.data.user.id,
      name: '',
      description: '',
      dateCreation: new Date(),
      sectionId: this.data.section.id,
      active: false,
      blocked: false,
      position: 0
    }
  }
}

@Component({
  selector: 'tasks-section-task-details.component.dialog',
  templateUrl: '../task/tasks-section-task-details.component.dialog.html',
  styleUrls: ['./tasks-section.component.css'],
  providers: [{
    provide: NG_VALUE_ACCESSOR,
    useExisting: forwardRef(() => TasksSectionTaskDetailsComponentDialog),
    multi: true,
  }]
})
export class TasksSectionTaskDetailsComponentDialog {
  constructor(
    public dialogRef: MatDialogRef<TasksSectionTaskDetailsComponentDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
    private myDataService: MyDataService,
    ) {}

  onNoClick(): void {
    this.editEnabled = false;
  }

  updateTask() {
    this.myDataService.updateTask(this.data.task).subscribe();
    this.myDataService.getTaskById(this.data.task.id).subscribe(result => { this.data.task = result; })
    this.editEnabled = false;
  }

  ngOnInit(): void {
    this.data.newComment = {
      content: '',
      writerId: this.data.user.id,
      dateCreation: new Date(),
      taskId: 0,
      id: 0
    };
  }

  deleteTask() {
    this.data.task.active = false;
    this.myDataService.updateTask(this.data.task).subscribe({
      complete: async () => {
        await this.delay(1000);
        this.dialogRef.close(false);
        this.data.loading = false;
      }
    });
  }

  delay(ms: number) {
    this.data.loading = true;
    return new Promise( resolve => setTimeout(resolve, ms) );
  }

  editEnabled = false;

  sendComment(){
    if (this.data.newComment.content != '')
    {
      this.data.newComment.dateCreation = new Date();
      this.data.newComment.writerId = this.data.user.id;
      this.data.newComment.taskId = this.data.task.id;
      this.myDataService.postComment(this.data.newComment).subscribe();
      this.data.task.comments.unshift(this.data.newComment);
    }
  }

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

  loading = false;

  ngOnInit(): void {
    this.myDataService.getAllSectionsByBoardId(this.boardId).subscribe((data) => {
      this.sections = data;
      this.loadTasks(this.sections);
      this.loadUsers();
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
    if (task.assigneeId != undefined && task.assigneeId != 0)
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

  users: Array<UserDTO> = [];

  loadUsers() {
    this.myDataService.getAllUsers().subscribe((data) => this.users = data);
  }

  @Input() editClicked = false;
  @Input() boardId = 1;
  newStatusName = '';
  
  emptyUser: User = {
    name: '',
    password: '',
    login: false,
    id: 0
  };

  @Input() user: User = {
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

  deleteSection(section: Section) {
    section.active = false;
    this.myDataService.updateSection(section).subscribe({ 
      complete: async () => {
        await this.delay(1000);
        this.ngOnInit()
        this.loading = false;
      }
    });
  }

  openNewStatusDialog(): void {
    const dialogRef = this.dialog.open(TasksSectionNewStatusComponentDialog, {
      data: { newStatusName: this.newStatusName, users: this.users, loading: this.loading },
    });
    
    dialogRef.afterClosed().subscribe({
      next: (result) => {
        if (result != false && result != '' && result != undefined)
        {
          this.newStatusName = result;

          this.addStatus(this.newStatusName);
        }
        this.newStatusName = '';
      },
      complete: async () => {
        await this.delay(1000);
        this.ngOnInit();
        this.loading = false;
      }
    });
  }

  delay(ms: number) {
    this.loading = true;
    return new Promise( resolve => setTimeout(resolve, ms) );
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
    this.newTask.creatorId = this.user.id;
    this.newTask.description = '';
    this.newTask.history.push(statushistory);
    this.newTask.blocked = false;

    const dialogRef = this.dialog.open(TasksSectionNewTaskComponentDialog, {
      data: { newTask: this.newTask, user: this.user, section: section, users: this.users, loading: this.loading },
    });

    dialogRef.afterClosed().subscribe({
      next: (result) => {
        if (result != false && this.newTask.name != '')
          this.addTask(section, result);
        this.newTask.name = '';
        this.newTask.history.pop();
      },
      complete: async () => {
        await this.delay(1000);
        this.ngOnInit();
        this.loading = false;
      }
    });
  }

  newComment : CommentDTO = {
    content: '',
    writerId: 0,
    id: 0,
    dateCreation: new Date(),
    taskId: 0
  };

  openTaskDetailsDialog(task: Task): void {
    const dialogRef = this.dialog.open(TasksSectionTaskDetailsComponentDialog, {
      data: { task: task, sections: this.sections, newComment: this.newComment, user: this.user, users: this.users, loading: this.loading },
    });

    dialogRef.afterClosed().subscribe({
      complete: async () => {
        await this.delay(1000);
        this.ngOnInit();
        this.loading = false;
      }
    });
  }

  addStatus(name: string) {
    let newSection: Section = {
      name: name,
      position: (this.sections.length + 1),
      active: true,
      id: 1,
      boardId: this.boardId,
      tasks: new Array<Task>
    };

    this.sections.push(newSection);

    let newSectionDTO: SectionDTO = {
      name: name,
      position: this.sections.length,
      active: true,
      id: 1,
      boardId: this.boardId,
    };

    function postNewSection(service: MyDataService) {
      service.postSection(newSectionDTO).subscribe();
    }
    function updateSections(service: MyDataService, sections: Array<Section>, boardId : number) {
      service.getAllSectionsByBoardId(boardId).subscribe((data) => {
        sections = data;
      });
    }

    setTimeout((sections : Array<Section> = this.sections, myDataService : MyDataService = this.myDataService) => {
      updateSections(myDataService, sections, sections[0].boardId);
    }, 500);
    postNewSection(this.myDataService);
  }

  removeTab(index: number) {
    this.sections.splice(index, 1);
  }

  addTask(section: Section, task : Task) {
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
      creatorId: this.user.id,
      id: task.id,
      dateCreation: task.dateCreation,
      sectionId: task.sectionId,
      active: task.active,
      creatorName: task.creatorName,
      assignee: task.assignee
    };

    let password = this.user.password;
    let userName = this.user.name;

    if (section.tasks.length != 0) {
      newTask.position = section.tasks[section.tasks.length-1].position + 1;
    }

    let newTaskDTO: TaskDTO = {
      id: 0,
      creatorId: newTask.creatorId,
      name: newTask.name,
      description: newTask.description,
      dateCreation: newTask.dateCreation,
      sectionId: section.id,
      active: true,
      blocked: newTask.blocked,
      position: newTask.position,
      assigneeId: newTask.assigneeId
    };

    section.tasks.push(newTask);

    function getUserId(service: MyDataService) {
      service.getUserId(userName, password).subscribe(result => { 
        newTaskDTO.creatorId = result.id;
      }); 
    }
    function postNewTask(service: MyDataService) {
        service.postTask(newTaskDTO).subscribe();
    }
    function updateTasks(service: MyDataService, tasks: Array<Task>, sectionId : number) {
      service.getAllTasksBySectionId(sectionId).subscribe((data) => {
        tasks = data;
      });
    }

    setTimeout(() => {
      postNewTask(this.myDataService);      
    }, 500);
    setTimeout(() => { 
      updateTasks(this.myDataService, section.tasks, section.id); 
    }, 500);
    getUserId(this.myDataService);
  }

  openTaskDetails(task: Task) {
    this.openTaskDetailsDialog(task);
  }
}
