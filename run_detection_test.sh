#This script acts as the validation tool for anyone recreating this project. 
#The script  automates the "attack" by making the specific API call your pipeline is designed to detect. It's the perfect way to test your CloudFormation deployment and prove that your security control works end-to-end. 


#!/bin/bash

# A script to simulate the reconnaissance API call (sts:GetCallerIdentity)
# to test the AWS native intrusion detection pipeline.

echo "----------------------------------------------------"
echo "AWS Intrusion Detection Pipeline Test"
echo "----------------------------------------------------"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null
then
    echo " Error: AWS CLI is not installed. Please install it to run this test."
    exit 1
fi

echo " AWS CLI is installed."
echo ""
echo "INFO: This script will use your default configured AWS credentials."
echo "      (You can set them up using 'aws configure')"
echo ""
read -p "Press [Enter] to run the simulation..."

echo ""
echo " Simulating reconnaissance API call: 'aws sts get-caller-identity'"
echo "----------------------------------------------------"

# Execute the target API call
aws sts get-caller-identity

# Check the exit code of the last command
if [ $? -eq 0 ]; then
    echo "----------------------------------------------------"
    echo " SUCCESS: API call was made successfully."
    echo " An email alert should be sent to the configured address shortly."
    echo "    (It may take 1-2 minutes for the event to process)"
else
    echo "----------------------------------------------------"
    echo "❌ FAILURE: The API call failed. Check your AWS credentials and permissions."
fi

echo ""
