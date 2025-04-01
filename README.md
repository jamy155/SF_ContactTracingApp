# Contact Tracing App

Sample Contact Tracing app built on Salesforce Platform.

![Contact_Tracing_App](https://github.com/jamy155/SF_ContactTracingApp/blob/7c03ff847007d92e4bc1051dc233978990f4825b/screenshots/Screenshots.png)

<b>This project is part of the Salesforce Apex Development course by Manish Choudhari </b>

The Contact Tracing App is a powerful Salesforce-based solution designed to track and manage health statuses, contact interactions, and location visits to help organizations monitor and mitigate health risks effectively.

##### This Project highlight all the following Fundamentals :

- Apex Development
- Async Apex
- HTML/CSS
- Aura Framework Development
- SOQL - Salesforce Object Query Language
- SOSL - Salesforce Object Search Language
- Object-Oriented Programming System

## Key Features & Objects:

#### Person Object

![Contact_Tracing_App](https://github.com/jamy155/SF_ContactTracingApp/blob/7c03ff847007d92e4bc1051dc233978990f4825b/screenshots/Persons.png)

- Stores records of all individuals in the system.

- Captures personal information along with their health status categorized as:

- 🟢 Green (Healthy)

- 🟡 Yellow (At Risk)

- 🟠 Orange (Potential Exposure)

- 🔴 Red (Confirmed Case)

#### Loaction Object

![Contact_Tracing_App](https://github.com/jamy155/SF_ContactTracingApp/blob/7c03ff847007d92e4bc1051dc233978990f4825b/screenshots/Loactions.png)

- Maintains records of various locations within the system.

- Each location has a status indicator (Green, Yellow, Orange, Red) to reflect its risk level based on recent visits and exposure data.

#### People Tracing Object

![Contact_Tracing_App](https://github.com/jamy155/SF_ContactTracingApp/blob/7c03ff847007d92e4bc1051dc233978990f4825b/screenshots/Loactions.png)

- Tracks interactions between two individuals.

- Stores details such as:

- Person 1 & Person 2 (who came into contact)

- Contact Type:

- 🏡 Cohabitant (Lives together)

- 🏢 Neighbor (Nearby contact)

- 🔄 Other (General contact)

- Contact Date (Date of interaction)

#### Location Tracing Object

![Contact_Tracing_App](https://github.com/jamy155/SF_ContactTracingApp/blob/7c03ff847007d92e4bc1051dc233978990f4825b/screenshots/Loactions.png)

- Logs location visits made by individuals.

- Tracks:

- Person (Who visited)

- Location (Place visited)

- Visit Date

#### Health Admin View

![Contact_Tracing_App](https://github.com/jamy155/SF_ContactTracingApp/blob/7c03ff847007d92e4bc1051dc233978990f4825b/screenshots/Health%20Admin%20View.png)

- A dedicated dashboard for health administrators to:

- Monitor & update people and location health statuses.

- Review contact tracing records to identify potential exposure chains.

- Take action based on risk assessments.

## Impact

This app enables organizations to efficiently track potential exposure, assess risks, and take proactive measures in managing health and safety within their environment. The Health Admin View serves as a central hub for decision-making, ensuring that the right precautions are taken promptly.
