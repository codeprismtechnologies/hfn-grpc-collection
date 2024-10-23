# **Kreya gRPC Configuration for HFN Backend**

This repository provides scripts to configure the **Kreya gRPC tool** for testing the HFN backend services. It handles the retrieval of proto files, environment setup, and management of authentication tokens. Both **Windows** and **macOS/Linux** are supported through separate scripts.

---

## **Contents**
- **`getProtos.bat`**: Batch script for **Windows** to pull proto files and set up the environment.
- **`getProtos.sh`**: Shell script for **macOS/Linux** with the same functionality.
- **`getToken.js`**: JavaScript script to fetch and store an authentication token in the configuration JSON used by Kreya for API testing.

---

## **Prerequisites**
1. **Git** installed.
2. **Node.js** installed (required to run `getToken.js`).
3. **Kreya gRPC Tool** installed: [Download Kreya](https://kreya.app).

---

## **Usage Instructions**

### **Step 1: Retrieve Proto Files**

Run the appropriate script for your operating system to download and set up proto files.

#### **Windows:**
```bash
getProtos.bat <environment> <branch>
```

#### **macOS/Linux:**
```bash
./getProtos.sh <environment> <branch>
```

- **environment**: Specify `dev` or `qa`.
- **branch**: Specify the branch (used only in `dev`).

#### **Example:**
```bash
./getProtos.sh dev feature-branch
```

This command:
- Downloads proto files for the required backend services.
- Switches to the specified branch if `dev` is selected.
- Organizes the files for use in Kreya.

---

### **Step 2: Set Authentication Token**

Use the `getToken.js` script to fetch an authentication token and store it in the required JSON configuration.

#### **Run the Script:**
```bash
node getToken.js
```

The script will:
1. Fetch the **auth token** using credentials from the environment variables.
2. Store the token inside the **Kreya configuration JSON** under `authConfigs` → `options.value`.
3. Ensure the token is available for testing gRPC APIs in Kreya.

---

### **Configuration JSON Structure**

Example of how the token will be saved in the Kreya JSON configuration:  

```json
{
  "authConfigs": [
    {
      "name": "Bearer-dev",
      "providerName": "static",
      "id": "46d83971-08d7-42b5-acc9-413e2ca27446",
      "options": {
        "value": "<AUTH_TOKEN>"
      }
    }
  ]
}
```

---

### **Note:**
- Ensure you run the appropriate **protos retrieval script** before testing APIs in Kreya.
- The **token refresh logic** ensures that the token is up-to-date and correctly stored inside the JSON file used by Kreya.
