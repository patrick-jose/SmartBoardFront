export interface Task {
    title: String,
    position: number,
    description: String,
    lastModified: Date,
    comments: String[],
    blocked: boolean,
    history: String[],
    assignee: String,
    status: String,
    creator: String
}