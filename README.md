Vincent Gagnon 101052796, Yufeng Liu 101258905
# Pulse Performance (comp3005_merged)

Welcome to our comp 3005 final project called Pulse Performance! This project is structured to include two components as Git submodules: the frontend (React) and backend (drizzle). This setup allows for modular development and deployment of the application. 

# Getting Started

To begin using this repository and its submodules, follow these steps:

###  Prerequisites
- git

### Clone the Repository
```bash
git clone --recurse-submodules git@github.com:paranoidAndroid0124/comp3005_merged.git
```
Note: the "--recurse-submodules" flag ensures that the frontend and backend are initialized and cloned with the main repository.

# Running the Project

Open a terminal inside the cloned git repository

### Backend
navigate to the backend submodules directory
```bash
cd backend
```

Follow the backend's README instructions for setting up and running the backend server

### Frontend
Navigate to the frontend submodules directory
```bash
cd frontend
```

Follow the frontend's README instruction for setting up and running the frontend application

# Demo

The following accounts were created for testing with the following roles:
- admin => email: "admin@admin.com" password: "password"
- trainer => email: "john@doe.com" password: "password"
- member => email: "max@gagne.com" password: "password"

# Report

### Conceptual Design

The database schema was designed with high flexibility in mind, incorporating a "role" and "userRole" table to facilitate the addition of various roles and properties. This setup allows for the customization of each role by adding role-specific attributes, ensuring that the schema can be tailored to meet the client's requirements upon deployment.

<!-- TODO: add more ? -->

### Reduction to Relation Schemas

// TODO: add ER model

### DDL File

The DDL file can be found in the "SQL" folder of this repository.

### DML File

The DML file can be found in the "SQL" folder of this repository.

### Implementation



### Bonus Features

### GitHub repository

This repository and its submodules have been made public. Each include their own README explaining how to install and start the program.