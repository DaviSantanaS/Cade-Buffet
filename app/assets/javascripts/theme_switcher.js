document.addEventListener('DOMContentLoaded', () => {
    const themeButton = document.getElementById('theme-button');
    const body = document.body;

    function toggleTheme() {
        body.classList.toggle('dark-theme');
        localStorage.setItem('theme', body.classList.contains('dark-theme') ? 'dark' : 'light');
        updateButton();
    }

    function updateButton() {
        themeButton.innerHTML = body.classList.contains('dark-theme') ? '&#9790;' : '&#9728;';
    }

    themeButton.addEventListener('click', toggleTheme);

    if (localStorage.getItem('theme') === 'dark') {
        body.classList.add('dark-theme');
        updateButton();
    }
});
