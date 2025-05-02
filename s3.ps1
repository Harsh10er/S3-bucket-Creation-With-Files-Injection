# Import the AWS S3 module
Import-Module AWS.Tools.S3

# Define the region
$region = "ap-south-1"

# Prompt for the S3 bucket name
$bucketName = Read-Host "Enter the S3 bucket name"

# Display the AWS region and bucket name
Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"

# Set the default AWS region
Set-DefaultAWSRegion -Region $region

# Check if the bucket exists
function BucketExists {
    try {
        Get-S3Bucket -BucketName $bucketName -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

if (-not (BucketExists)) {
    # Create the S3 bucket if it doesn't exist
    New-S3Bucket -BucketName $bucketName
    Write-Host "Bucket created: $bucketName"
} else {
    Write-Host "Bucket already exists: $bucketName"
}

# Create a file
$fileName = "myfile.txt"
$fileContent = "Hello world!"
Set-Content -Path $fileName -Value $fileContent

# Upload the file to the S3 bucket
Write-S3Object -BucketName $bucketName -File $fileName -Key $fileName

Write-Host "File uploaded: $fileName to bucket: $bucketName"
