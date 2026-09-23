import os
from pathlib import Path

import boto3
from dotenv import load_dotenv


# ============================================================
# LOAD ENVIRONMENT VARIABLES
# ============================================================

ENV_PATH = r"D:\big data\Project\aws-ecommerce-data-pipeline\.env"

load_dotenv(ENV_PATH, override=True)


# ============================================================
# AWS CONFIGURATION
# ============================================================

AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
AWS_REGION = os.getenv("AWS_DEFAULT_REGION")

BUCKET_NAME = os.getenv("AWS_BUCKET_NAME")
S3_PREFIX = os.getenv("S3_PREFIX", "raw/ecommerce")
OUTPUT_DIR = os.getenv("OUTPUT_DIR", "ecommerce_data")


# ============================================================
# VALIDATE CONFIGURATION
# ============================================================

required_variables = {
    "AWS_ACCESS_KEY_ID": AWS_ACCESS_KEY_ID,
    "AWS_SECRET_ACCESS_KEY": AWS_SECRET_ACCESS_KEY,
    "AWS_DEFAULT_REGION": AWS_REGION,
    "AWS_BUCKET_NAME": BUCKET_NAME,
}

for variable_name, variable_value in required_variables.items():
    if not variable_value:
        raise ValueError(f"Missing environment variable: {variable_name}")


# ============================================================
# CREATE S3 CLIENT
# ============================================================

s3 = boto3.client(
    "s3",
    aws_access_key_id=AWS_ACCESS_KEY_ID,
    aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
    region_name=AWS_REGION,
)


# ============================================================
# TEST AWS CONNECTION
# ============================================================

print("Testing AWS connection...")

s3.head_bucket(Bucket=BUCKET_NAME)

print("AWS authentication successful.")
print(f"Bucket: {BUCKET_NAME}")
print(f"Region: {AWS_REGION}")
print()


# ============================================================
# UPLOAD FUNCTION
# ============================================================

def upload_directory_to_s3(local_directory, bucket_name, s3_prefix):

    local_directory = Path(local_directory)

    if not local_directory.exists():
        raise FileNotFoundError(
            f"Directory not found: {local_directory}"
        )

    files = [
        file_path
        for file_path in local_directory.rglob("*")
        if file_path.is_file()
    ]

    if not files:
        print("No files found.")
        return

    print(f"Found {len(files)} files.")
    print()

    for file_path in files:

        relative_path = file_path.relative_to(local_directory)

        s3_key = (
            f"{s3_prefix}/{relative_path.as_posix()}"
        )

        print(
            f"Uploading: {file_path} "
            f"-> s3://{bucket_name}/{s3_key}"
        )

        s3.upload_file(
            str(file_path),
            bucket_name,
            s3_key,
        )

        print("Uploaded successfully.")
        print()


# ============================================================
# MAIN
# ============================================================

if __name__ == "__main__":

    print("=" * 60)
    print("AWS E-COMMERCE DATA UPLOAD")
    print("=" * 60)
    print()

    upload_directory_to_s3(
        OUTPUT_DIR,
        BUCKET_NAME,
        S3_PREFIX,
    )

    print("=" * 60)
    print("ALL FILES UPLOADED SUCCESSFULLY")
    print("=" * 60)