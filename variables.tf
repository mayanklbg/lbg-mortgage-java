{
    "name": "Create GKE Namespace",
    "on": {
      "workflow_dispatch": {
        "branches": [
          "main"
        ],
        "inputs": {
            "consumerId": {
              "required": true,
              "type": "string"
            },
            "costCenter": {
              "required": true,
              "type": "string"
            },
            "aadGroupId": {
              "required": true,
              "type": "string"
            },
            "requestId": {
              "required": true,
              "type": "string"
            }
          }
      }
    },
    "env": {
      "GOOGLE_APPLICATION_CREDENTIALS": "${{ secrets.GKE_SHARED_SECRET }}",
      "PROJECT_ID": "",
      "CLUSTER_NAME": "",
      "ZONE": "",
      "CLUSTER_IP": "",
      "USER_GKE_GSA": "",
      "NAMESPACE": ""
    },
    "jobs": {
      "build": {
        "runs-on": "ubuntu-latest",
        "steps": [
          {
            "uses": "actions/checkout@v3"
          },
          {
            "id": "auth",
            "name": "Authenticate to Google Cloud using secrets",
            "uses": "google-github-actions/auth@v0",
            "with": {
              "credentials_json": "${{ secrets.GKE_SHARED_SECRET }}"
            }
          },
          {
            "name": "Activate Service Account",
            "run": "gcloud config set account shared-k8s@shared-svc1-project.iam.gserviceaccount.com\ngcloud auth activate-service-account shared-k8s@shared-svc1-project.iam.gserviceaccount.com --key-file=$GOOGLE_APPLICATION_CREDENTIALS --project=$PROJECT_ID\n"
          }
        ]
      }
    }
  }