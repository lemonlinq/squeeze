document.addEventListener('DOMContentLoaded', function () {
    // Automatically hide flash messages after 2 seconds
    setTimeout(function () {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease'; // Include transform transition
            alert.style.opacity = '0'; // Fade out
            alert.style.transform = 'translate(-50%, -30px)'; // Keep horizontal centering, move up by 30px
            setTimeout(() => alert.remove(), 500); // Remove from the DOM after fading out
        });
    }, 2000); // 2000 milliseconds = 2 seconds
});