import pandas as pd
from jira import JIRA
import smtplib
from email.mime.text import MIMEText

# Jira authentication
jira_url = 'https://datumanalysis.atlassian.net'
jira_username = 'almaweri@datumanalysis.com'
jira_password = 'Cancon2015'

# Email configuration
smtp_server = 'smtp.gmail.com'
smtp_username = 'maged.almaweri@gmail.com'
smtp_password = 'Cancon2015'
from_email = 'maged.almaweri@gmail.com'

# Connect to Jira
jira = JIRA(server=jira_url, basic_auth=(jira_username, jira_password))

# Read data from Jira
query = 'project = "DAP" and created >= -30d'
issues = jira.search_issues(query)

# Create a DataFrame from the issues
data = [
    {
        "Jira": issue.key,
        "Issue Title": issue.fields.summary,
        "Assigned To": issue.fields.assignee.displayName if issue.fields.assignee else "",
        "Reporter": issue.fields.reporter.displayName,
        "Status": issue.fields.status.name,
        "Resolution Comment": issue.fields.resolution.description if issue.fields.resolution else "",
        "Created On": issue.fields.created,
        "Last updated": issue.fields.updated,
        "Resolved Date": issue.fields.resolutiondate,
        "Code Last Updated By": "",
        "Component": issue.fields.components[0].name if issue.fields.components else "",
    }
    for issue in issues
]

df = pd.DataFrame(data)

# Generate statistics reports
# Add your code for generating reports here

# Send notifications
def send_email(to_email, subject, body):
    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = from_email
    msg['To'] = to_email

    with smtplib.SMTP(smtp_server) as server:
        server.login(smtp_username, smtp_password)
        server.send_message(msg)

# Notify developers, team leads, and managers
# Add your code for sending notifications here
