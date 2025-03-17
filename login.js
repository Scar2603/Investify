// Check login status when clicking the login button
var isLoggedIn = localStorage.getItem("isLoggedIn");

// Handle login button 1
var loginBtn = document.getElementById("loginBtn");
if (loginBtn) {
    loginBtn.onclick = function () {
        if (isLoggedIn && isLoggedIn === "true") {
            window.location.href = "home.html"; // Redirect to home page
        } else {
            var loginPopup = document.getElementById("loginpopup");
            loginPopup.style.display = "block"; // Show login popup if not logged in
        }
    };
}

// Handle login button 2
var loginBtn2 = document.getElementById("loginBtn2");
if (loginBtn2) {
    loginBtn2.onclick = function () {
        if (isLoggedIn && isLoggedIn === "true") {
            window.location.href = "home.html"; // Redirect to home page
        } else {
            var loginPopup = document.getElementById("loginpopup");
            loginPopup.style.display = "block"; // Show login popup if not logged in
        }
    };
}

// Close login popup
var loginPopup = document.getElementById("loginpopup");
var registerPopup = document.getElementById("registerPopup");
var loginClose = document.getElementsByClassName("close")[0];
var registerClose = document.getElementById("registerClose");

// Function to clear input fields
function clearLoginFields() {
    document.getElementById("username").value = "";
    document.getElementById("password").value = "";
}

// Close login popup when clicking the close button
if (loginClose) {
    loginClose.onclick = function () {
        loginPopup.style.display = "none";
        clearLoginFields();
    };
}

// Function to clear input fields
function clearRegisterFields() {
    document.getElementById("name").value = "";
    document.getElementById("newUsername").value = "";
    document.getElementById("newPassword").value = "";
}

// Close register popup when clicking the close button
if (registerClose) {
    registerClose.onclick = function () {
        registerPopup.style.display = "none";
        clearRegisterFields();
    };
}


// Close register popup
var registerClose = document.getElementById("registerClose");
if (registerClose) {
    registerClose.onclick = function () {
        var registerPopup = document.getElementById("registerPopup");
        registerPopup.style.display = "none"; // Hide register popup
    };
}

// Close popup when clicking outside
window.onclick = function (event) {
    if (event.target === loginPopup) {
        loginPopup.style.display = "none";
        clearLoginFields(); // Clear login fields
    }
    if (event.target === registerPopup) {
        registerPopup.style.display = "none";
        clearRegisterFields(); // Clear register fields
    }
};

// Register Functionality
document.getElementById("registerSubmit").onclick = function (event) {
    event.preventDefault(); // Prevent form submission

    // Get input from registration form
    const name = document.getElementById("name").value;
    const newUsername = document.getElementById("newUsername").value;
    const newPassword = document.getElementById("newPassword").value;

    // Retrieve all registered usernames from localStorage
    let users = JSON.parse(localStorage.getItem("users")) || []; // Parse existing users or initialize empty array

    // Check if the username already exists
    const isUsernameTaken = users.some(user => user.username === newUsername);

    if (isUsernameTaken) {
        alert("Username already taken. Please choose a different username.");
    } else if (name && newUsername && newPassword) {
        // Add the new user to the list of users
        users.push({ name: name, username: newUsername, password: newPassword });
        localStorage.setItem("users", JSON.stringify(users)); // Save updated list of users to localStorage
        alert("Registration successful! Please login now.");
        document.getElementById("registerPopup").style.display = "none"; // Close the popup
    } else {
        alert("Please fill in all fields to register.");
    }
};



// Login Functionality
document.getElementById("loginSubmit").onclick = function (event) {
    event.preventDefault(); // Prevent form submission

    // Retrieve all registered users from localStorage
    let users = JSON.parse(localStorage.getItem("users")) || []; // Get the list of users

    // Get user input
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    // Check credentials
    const isValidUser = users.some(user => user.username === username && user.password === password);

    if (isValidUser) {
        localStorage.setItem("isLoggedIn", "true"); // Mark as logged in
        const loggedInUser = users.find(user => user.username === username); // Get the logged-in user's details
        localStorage.setItem("name", loggedInUser.name); // Store the user's name for display later
        window.location.href = "home.html"; // Redirect to home page
    } else {
        alert("Invalid username or password. Please try again.");
    }
};


// Logout Functionality
var logoutBtn = document.getElementById("logoutBtn");
if (logoutBtn) {
    logoutBtn.onclick = function () {
        localStorage.removeItem("isLoggedIn"); // Clear login status
        window.location.href = "intro.html"; // Redirect to intro page
    };
}

// Check login status on home page
if (document.body.id === "homePage") { // Add 'homePage' id in the body of home.html
    var homeIsLoggedIn = localStorage.getItem("isLoggedIn");
    if (!homeIsLoggedIn || homeIsLoggedIn !== "true") {
        alert("You need to login to access the website.");
        window.location.href = "intro.html"; // Redirect to intro page
    }
}

// Intercept browser back button
window.onpopstate = function () {
    if (!localStorage.getItem("isLoggedIn")) {
        alert("You need to login to access the website."); // Show message
        window.location.href = "intro.html"; // Redirect to intro page
    }
};

// Switch to Register Popup from Login Popup
document.getElementById("switchToRegister").onclick = function (event) {
    event.preventDefault(); // Prevent link from navigating
    document.getElementById("loginpopup").style.display = "none"; // Hide login popup
    document.getElementById("registerPopup").style.display = "block"; // Show register popup
};

// Switch to Login Popup from Register Popup
document.getElementById("switchToLogin").onclick = function (event) {
    event.preventDefault(); // Prevent link from navigating
    document.getElementById("registerPopup").style.display = "none"; // Hide register popup
    document.getElementById("loginpopup").style.display = "block"; // Show login popup
};
