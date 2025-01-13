var smiley = document.querySelector('.smiley');

document.querySelector('.image.avatar48').addEventListener('mouseenter', function() {
    smiley.style.opacity = '1';  // Show smiley
});

document.querySelector('.image.avatar48').addEventListener('mouseleave', function() {
    // Keep smiley visible for 5 seconds after mouse leaves
    setTimeout(function() {
        smiley.style.opacity = '0';  
    }, 5000);  // = 5 seconds
});
