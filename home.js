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

// Intercept the browser back button
window.onpopstate = function (event) {
    if (!localStorage.getItem("isLoggedIn")) { 
        alert("You need to login to access the website."); // Show the message
        window.location.href = "index.html"; // Redirect to the index page
    }
};


// Toggle See All and Hide All Stocks
document.getElementById("stocksSeeAll").onclick = function () {
    const extraStocksList = document.getElementById("extraStocksList");
    const seeAllHeading = document.getElementById("stocksSeeAll");

    if (extraStocksList.style.display === "none") {
        extraStocksList.style.display = "flex"; // Show extra stocks
        seeAllHeading.textContent = "Hide All Stocks"; // Update text
    } else {
        extraStocksList.style.display = "none"; // Hide extra stocks
        seeAllHeading.textContent = "See All Stocks"; // Update text
    }
};


// Toggle See All and Hide All Mutual Funds
document.getElementById("fundsSeeAll").onclick = function () {
    const extraFundsList = document.getElementById("extraFundsList");
    const fundsSeeAll = document.getElementById("fundsSeeAll");

    if (extraFundsList.style.display === "none") {
        extraFundsList.style.display = "flex"; // Show extra funds
        fundsSeeAll.textContent = "Hide All Mutual Funds"; // Update text
    } else {
        extraFundsList.style.display = "none"; // Hide extra funds
        fundsSeeAll.textContent = "See All Mutual Funds"; // Update text
    }
};
