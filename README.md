# Want Ads

Ruby on Rails web application for managing volunteer roles, projects, and tasks.

## User Stores

(not all implemented)

1. Organizers can publish projects that describe work that needs to be done
   1. Organizers can specify:
      1. Title
      1. Description
      1. Mark down
      1. State
          1. Inactive
          1. Active
          1. Complete
          1. Cancelled
      1. Person
      1. Roles
      1. Schedule
      1. Goals
    1. Projects can be published by making them “Active”
    1. Projects can be closed by marking them “Complete” or “Cancelled”
    1. Any volunteer associated with the project is notified automatically
    1. Projects can have conversations
    1. Publication can be to just a specific set of users (group, individuals)
1. Volunteers can browse through available projects
    1. All projects are listed on the main page
    1. The list can be sorted
    1. The list can be searched through
    1. The list can be filtered to match the skills and availability of the Volunteer
1. Volunteers and Organizers can be identified solely by the email address in their Person record
    1. A person record has:
        1. Email address
        1. Name
        1. Type
        1. Password
        1. Skills
        1. Communication Preferences
    1. Any Person with a password can login
        1. Admins can assign organizers passwords to login
        1. Logging in creates a session
            1. Sessions can be short lived if on a “public” computer
        1. People can sign up for an account with a password
    1. Admins can make People Organizers
    1. Instead of logging in, people can simply verify their email address
        1. The verification also performs the action that prompted it
    1. People can modify their own profiles
        1. They can set their skills
        1. They can specify their Communication Preferences
    1. People have a view through the website into all Communications sent to them
1. Volunteers can express interest in Roles
    1. Expressing interest notifies the Organizer with the Volunteer’s email address
    1. Organizers can list people who have expressed interest in a Role
    1. Expressing interest allows for conversation between the organizer and the volunteer
    1. Expressing interest asks to confirm Skills and Availability
1. Organizers can assign volunteers to a Role
    1. Assigned volunteers can see other People assigned to the other Roles
    1. Assigned volunteers can see the tasks on the project
1. Organizers can assign tasks to Projects
    1. Tasks have the following fields:
        1. Title
        1. Description
        1. Status
        1. Project
        1. Person
        1. Role
        1. Conversation
        1. Start Time
        1. End Time
        1. Sub Tasks
        1. Dependent on Tasks
        1. Goals
    1. Organizers can create sub tasks under tasks
    1. Organizers can mark tasks dependent on other tasks
    1. Volunteers receive reminders of upcoming tasks
1. Organizers can create events under projects
    1. Events have:
        1. Title
        1. Start Time
        1. End Time
        1. Location
        1. Tasks
1. Volunteers can sign up for an account
    1. In order to avoid verifying their email address every time, they can sign up for an account if they want
1. Organizers can create groups of volunteers
    1. Organizers can assign volunteers to groups
    1. Volunteers can express interest in groups
1. Organizers can search through the list of existing volunteers
1. Admins can import data into the database
    1. NationBuilder style: map CSV headers to fields as you import
    1. Can import
        1. Volunteers
        1. Events
1. Admins can export data
    1. Volunteers
    1. Events
    1. Projects
    1. Tasks
1. Organizers can create campaigns that span multiple projects
    1. Campaigns have:
        1. Title
        1. Description
        1. Projects
        1. Goals
        1. Start date
        1. End date
1. Organizers can be grouped under Organizations
