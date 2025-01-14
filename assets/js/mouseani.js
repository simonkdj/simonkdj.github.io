const coords = { x: 0, y: 0 };
const circles = document.querySelectorAll(".circle");

const colors = [
    "#d4b5ff",
    "#cfa6fd",
    "#c694f9",
    "#bf8ff7",
    "#b27df3",
    "#ab78f1",
    "#9f67ec",
    "#9963ea",
    "#8d52e5",
    "#874ee3",
    "#7c3cdc",
    "#7636da",
    "#6824d5",
    "#621fd3",
    "#5211ce",
    "#4c0bcc",
    "#3a00c7",
    "#3400c4",
    "#2900be",
    "#2300bc",
    "#1400b4",
    "#0e00b0"
];

circles.forEach(function (circle, index) {
    circle.x = 0;
    circle.y = 0;
    circle.style.backgroundColor = colors[index % colors.length];
});

function updateCursorPosition(e) {
    coords.x = e.clientX; // Viewport-relative x-coordinate
    coords.y = e.clientY; // Viewport-relative y-coordinate
}

window.addEventListener("mousemove", updateCursorPosition);

function animateCircles() {
    let x = coords.x;
    let y = coords.y;

    circles.forEach(function (circle, index) {
        circle.style.left = x - 12 + "px";
        circle.style.top = y - 12 + "px";
        circle.style.scale = (circles.length - index) / circles.length;

        circle.x = x;
        circle.y = y;

        const nextCircle = circles[index + 1] || circles[0];
        x += (nextCircle.x - x) * 0.3;
        y += (nextCircle.y - y) * 0.3;
    });

    requestAnimationFrame(animateCircles);
}

animateCircles();

function isTouchDevice() {
    return 'ontouchstart' in window || navigator.maxTouchPoints > 0;
}

if (isTouchDevice()) {
    const circles = document.querySelectorAll(".circle");
    circles.forEach(circle => {
        circle.style.display = "none"; // Hides the circles
    });
}
