// Check if user is logged in
var isLoggedIn = localStorage.getItem("isLoggedIn");

if (!isLoggedIn || isLoggedIn !== "true") {
    alert("You need to login to access the website."); // Show the message
    window.location.href = "index.html"; // Redirect to the login page
}

// Display the user's name
var userName = localStorage.getItem("name") || "User"; // Fetch the user's name from localStorage
var welcomeText = document.getElementById("welcomeText");
welcomeText.textContent = `Welcome, ${userName}!`;

// Logout Function
document.getElementById("logoutBtn").onclick = function () {
    localStorage.removeItem("isLoggedIn"); // Clear login status
    localStorage.removeItem("name"); // Clear stored user name
    window.location.href = "index.html"; // Redirect to index page
};
