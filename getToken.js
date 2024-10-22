const fs = require("fs");
const axios = require("axios");
require("dotenv").config(); // Load environment variables from .env file

const args = process.argv.slice(2); // Skip 'node' and script name
const ENV = args[0] || "dev"; // Example usage: node token_handler.js dev or qa

// Select the appropriate API key based on the environment
console.log(ENV === "qa");
const API_KEY = ENV === "qa" ? process.env.QA_API_KEY : process.env.DEV_API_KEY;
const AUTH_USERNAME = process.env.AUTH_USERNAME;
const AUTH_PASSWORD = process.env.AUTH_PASSWORD;
const TOKEN_FILE = ".env"; // The .env file path

const JSON_FILE_PATH = "./Api collection/gamification-service/gamification-service-api.krproj";

// Function to update the token in the JSON file
function updateJsonToken(token) {
  const jsonData = JSON.parse(fs.readFileSync(JSON_FILE_PATH, "utf8"));

  // Set the token in the correct location (authConfigs -> options -> value)
  ENV === "qa"
    ? (jsonData.authConfigs[1].options.value = token)
    : (jsonData.authConfigs[0].options.value = token);

  // Write the updated JSON back to the file
  fs.writeFileSync(JSON_FILE_PATH, JSON.stringify(jsonData, null, 2));
  console.log("Token successfully updated in JSON file.");
}
// Function to update the .env file with new values
function updateEnv(newValues) {
  const envConfig = fs.readFileSync(TOKEN_FILE, "utf8");
  let updatedConfig = envConfig;

  for (const [key, value] of Object.entries(newValues)) {
    const regex = new RegExp(`^${key}=.*`, "m");
    updatedConfig = updatedConfig.replace(regex, `${key}=${value}`);
  }

  fs.writeFileSync(TOKEN_FILE, updatedConfig);
  console.log("Environment variables updated.");
}

// Function to get the current timestamp
function getCurrentTimestamp() {
  return Date.now();
}

// Function to fetch a new token from the API
async function fetchNewToken() {
  try {
    const response = await axios.post(
      `https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${API_KEY}`,
      {
        email: AUTH_USERNAME,
        password: AUTH_PASSWORD,
        returnSecureToken: true,
      },
      { headers: { "Content-Type": "application/json" } }
    );

    const { idToken } = response.data;
    console.log("New token fetched:", idToken);
    updateJsonToken(idToken);

    // Save token and timestamp in the .env file
    updateEnv({
      AUTH_TOKEN: idToken,
      TOKEN_TIMESTAMP: getCurrentTimestamp(),
    });

    return idToken;
  } catch (error) {
    console.error("Error fetching token:", error);
    throw error;
  }
}

// Function to retrieve and validate the token
async function getToken() {
  const token = process.env.AUTH_TOKEN;
  const tokenTimestamp = parseInt(process.env.TOKEN_TIMESTAMP, 10) || 0;
  const elapsed = getCurrentTimestamp() - tokenTimestamp;

  if (token && elapsed < 20 * 60000) {
    console.log("Using cached token:", token);
    return token;
  }

  console.log("Cached token expired or not found. Fetching new token...");
  return await fetchNewToken();
}

// Main execution
(async () => {
  try {
    const token = await getToken();
    console.log("Token in use:", token);
  } catch (error) {
    console.error("Failed to retrieve token:", error);
  }
})();
