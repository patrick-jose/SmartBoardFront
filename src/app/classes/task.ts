import { CommentDTO } from "./commentDTO";
import { User } from "./user";

export interface Task {
    name: String,
    position: number,
    description: String,
    lastModified: Date,
    comments: Array<CommentDTO>,
    blocked: boolean,
    history: String[],
    assigneeId: number,
    status: String,
    creatorId: number,
    id: number,
    dateCreation: Date,
    sectionId: number,
    active: boolean,
    creatorName : String,
    assignee: User
}