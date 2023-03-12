export interface Task {
    title: String,
    position: number,
    description: String,
    lastModified: Date,
    comments: String[],
    blocked: boolean,
    history: History[],
    assignee: String,
    status: String
}