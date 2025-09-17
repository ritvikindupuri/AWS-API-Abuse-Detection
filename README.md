# Cloud Intrusion Detection & Alerting Pipeline (AWS Native)

This project demonstrates a fully serverless, cloud-native intrusion detection and alerting pipeline built entirely on AWS. I simulated a common credential abuse scenario from a Kali Linux attack machine and successfully detected and alerted on the malicious activity in real time.

The core of this project is its simplicity and power: no third-party tools, no agents to install—just clean, effective, and scalable infrastructure security using core AWS services, all within the Free Tier.

---
## Threat Scenario & Detection Pipeline

The pipeline was designed to detect an early-stage indicator of compromise: a threat actor using stolen credentials to perform basic reconnaissance. A common first step for an attacker is to validate the permissions of stolen keys using the `sts:GetCallerIdentity` API call.

My serverless pipeline detects this specific activity and triggers an immediate alert:

1.  **Log Event:** An attacker makes a suspicious API call. AWS CloudTrail records this as a management event.
2.  **Detection Trigger:** An Amazon EventBridge rule, with a custom event pattern, is constantly scanning the CloudTrail event stream. It is configured to match only the `sts:GetCallerIdentity` event.
3.  **Alert Sent:** When the event is matched, EventBridge triggers its target, an Amazon SNS (Simple Notification Service) topic.
4.  **Email Notification:** SNS immediately pushes the alert to all subscribed endpoints, in this case, sending an email to the security administrator.

<img src="./assets/Cloud Native alerting pipeline.jpg" width="800" alt="Cloud Native Intrusion Detection and Alerting Pipeline Diagram">
*<p align="center">Figure 1: The end-to-end serverless detection and alerting pipeline.</p>*

---
## Implementation & Configuration

The pipeline was constructed using three core AWS services.

### Step 1: Enabling the Data Source (AWS CloudTrail)
The foundation of any detection capability is reliable logging. A multi-region AWS CloudTrail trail was enabled to ensure all management events across the account are captured and delivered for analysis.

<img src="./assets/CloudTrail Enablement.jpg" width="800" alt="Screenshot of AWS CloudTrail enabled">
*<p align="center">Figure 2: A multi-region trail ("APITrail") actively logging all API events.</p>*

### Step 2: Creating the Detection Logic (Amazon EventBridge)
This is the brain of the pipeline. An EventBridge rule was created to filter the vast number of CloudTrail events for the specific recon activity. The event pattern below is configured to precisely match the `GetCallerIdentity` API call.

<img src="./assets/EventBridge GetCallerIdentity Rule.jpg" width="800" alt="Screenshot of the EventBridge rule and event pattern">
*<p align="center">Figure 3: The EventBridge rule with the custom event pattern for detection.</p>*

---
## End-to-End Test: Simulating the Attack

To validate the pipeline, I used the AWS CLI from a Kali Linux environment with a set of (simulated) stolen credentials.

The screenshot below captures the exact moment of the test. In the background, you can see the email inbox. Overlaid is the Kali terminal issuing the `aws sts get-caller-identity` command. Immediately upon execution, the email alerts from SNS began arriving, proving the pipeline's effectiveness in delivering real-time notifications.

<img src="./assets/Real Time alert trigger.jpg" width="800" alt="Composite screenshot showing the attack command and the resulting email alerts">
*<p align="center">Figure 4: The simulated attack from Kali Linux instantly triggering email alerts.</p>*

---
## 🚀 Skills & Technologies Demonstrated

* **Cloud Security:** Designing and implementing detective controls for cloud environments.
* **Intrusion Detection:** Using cloud-native services to detect indicators of compromise (IoCs) and reconnaissance TTPs (Tactics, Techniques, and Procedures).
* **AWS CloudTrail:** Enabling and utilizing API logging for security monitoring and forensics.
* **Amazon EventBridge:** Creating event-driven architectures and writing custom event patterns for fine-grained filtering.
* **Amazon SNS:** Configuring automated alerting and notification systems.
* **Threat Simulation:** Using offensive tools (Kali Linux) to validate the effectiveness of defensive controls.
* **Serverless Architecture:** Building a scalable, cost-effective solution without managing any servers.
