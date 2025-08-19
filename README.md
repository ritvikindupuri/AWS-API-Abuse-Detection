# AWS API Abuse Detection

**Cloud-Native Detection Pipeline for Unauthorized AWS CLI Activity**  
*Cloud Security | Detection Engineering | Blue Team | AWS-native Tools*

---

## 📌 Project Overview

This project simulates an AWS credential abuse scenario and demonstrates how to detect it using only **AWS-native services**. An attacker uses stolen credentials to perform identity enumeration via the AWS CLI. This behavior is captured and alerted in real time using **CloudTrail**, **EventBridge**, and **SNS**—with no third-party tools required.

The goal: Build a production-ready detection pipeline that reflects real-world cloud security operations.

---

## 🎯 Objectives

- Simulate a **cloud intrusion** using compromised AWS access keys
- Detect suspicious API usage (`sts get-caller-identity`) via **CloudTrail**
- Build a **real-time alerting pipeline** using EventBridge and SNS
- Send structured email alerts to defenders
- Validate alerts by analyzing log artifacts in S3

---

## 🛠️ Tools & Technologies

| Technology     | Purpose                         |
|----------------|----------------------------------|
| AWS CLI        | Attacker simulation              |
| Kali Linux     | Attacker host environment        |
| CloudTrail     | API call logging                 |
| EventBridge    | Detection logic / rule engine    |
| Amazon SNS     | Email-based alerting             |
| Amazon S3      | Log storage and validation       |

---

## 📐 Architecture

### Detection Flow

Attacker (AWS CLI) → CloudTrail → EventBridge → SNS → Email Alert


### Figure 1 - Cloud Intrusion Detection & Alerting Pipeline (AWS Native)  
_Attach your pipeline diagram here_  
<img width="800" height="163" alt="image" src="https://github.com/user-attachments/assets/e063e6e4-3b0b-4d00-bf58-4f76f97db5b4" />

High-level architecture of a real-time detection system that identifies suspicious AWS API calls using CloudTrail, EventBridge, and SNS. The pipeline triggers email alerts to notify users when attacker-like behavior (e.g., sts:GetCallerIdentity) is detected. Simulated attacker activity was generated using Kali Linux with stolen credentials.

---

## 🧪 Attack Simulation

Using Kali Linux, AWS CLI was configured with stolen access credentials. The attacker executed:

```bash
aws sts get-caller-identity
This command is commonly used by adversaries to validate access and enumerate the AWS account.

🔍 Detection Rule
The following EventBridge rule was created to detect unauthorized identity enumeration:

json
Copy
Edit
{
  "source": ["aws.sts"],
  "detail-type": ["AWS API Call via CloudTrail"],
  "detail": {
    "eventName": ["GetCallerIdentity"]
  }
}
Once matched, the rule forwards the event to an SNS topic with email subscription(s).

🚨 Alerting and Notification
Upon detection, SNS sends an email alert to the defender's inbox, including:

API call details (eventName, accountId, sourceIPAddress)

A link to the CloudTrail log object in S3

Timestamp and region metadata

📸 End-to-End Workflow View
This composite screenshot shows the entire flow—from attacker activity to analyst notification.

Attach the composite image here

✅ Results
Real-time detection of unauthorized API usage

Email alert delivered within seconds of the triggering event

Alert metadata matched correctly against CloudTrail logs

No third-party tools or services used—entirely AWS-native

💡 Skills Demonstrated
Detection engineering using AWS-native services

SOC-style alert triage and log correlation

Cloud threat simulation (TTP: credential abuse + enumeration)

Event-driven security architecture in AWS

CloudTrail log analysis and validation

🔧 Opportunities for Future Enhancements
Detect other suspicious API calls (CreateAccessKey, PassRole, etc.)

Add automated remediation via AWS Lambda (e.g., disable key, tag IAM user)

Route alerts into a centralized SIEM (e.g., OpenSearch, Splunk)

Visualize alerts in Grafana or CloudWatch dashboards

Integrate with SOAR platforms for full incident response playbooks


👤 Author
Ritvik Indupuri 
Cloud Security | Detection Engineering | Blue Team Operations


📎 License
This project is open for learning and demonstration purposes only. All simulation performed in controlled, non-production AWS environments.
