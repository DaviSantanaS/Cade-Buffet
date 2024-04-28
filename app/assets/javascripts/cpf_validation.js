document.addEventListener("DOMContentLoaded", function() {
    const userRoleSelect = document.getElementById('user_role');
    const cpfField = document.querySelector('.cpf_field');

    userRoleSelect.addEventListener('change', function() {
    if (userRoleSelect.value === 'false') {
        cpfField.style.display = 'block';
        } else {
        cpfField.style.display = 'none';
        }
    });
});
