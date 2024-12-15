const togglePasswordVisibility = () => {
    document.querySelectorAll('.input-group-text').forEach(toggle => {
        toggle.addEventListener('click', () => {
            const toggleId = toggle.dataset.toggleId;
            const input = document.querySelector(`.password-field[data-toggle-id="${toggleId}"]`);
            const icon = toggle.querySelector('i');

            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.replace('bi-eye-slash', 'bi-eye');
            } else {
                input.type = 'password';
                icon.classList.replace('bi-eye', 'bi-eye-slash');
            }
        });
    });
};

togglePasswordVisibility();