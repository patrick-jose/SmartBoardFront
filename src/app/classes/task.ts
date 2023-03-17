import { CommentDTO } from "./commentDTO";
import { StatusHistory } from "./statusHistory";
import { User } from "./user";

export interface Task {
    name: String,
    position: number,
    description: String,
    lastModified: Date,
    comments: Array<CommentDTO>,
    blocked: boolean,
    history: Array<StatusHistory>,
    assigneeId: number,
    section: String,
    creatorId: number,
    id: number,
    dateCreation: Date,
    sectionId: number,
    active: boolean,
    creatorName : String,
    assignee: User
}

export interface TaskDTO {
    id: number,
    creatorId: number,
    name: String,
    description: String,
    dateCreation: Date,
    sectionId: number,
    active: boolean,
    blocked: boolean,
    assigneeId?: number,
    position: number
}