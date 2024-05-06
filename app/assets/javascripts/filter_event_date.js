document.addEventListener('DOMContentLoaded', function() {
    const eventTypeSelect = document.getElementById('order_event_type_id');
    const eventDateField = document.getElementById('order_event_date');

    // Função para validar a entrada da data
    function validateDateInput() {
        // Verifica se a data foi realmente inserida antes de validar
        if (!eventDateField.value) {
            return; // Se não há data, retorna sem fazer nada
        }

        const selectedDate = new Date(eventDateField.value + 'T00:00'); // Usar 'T00:00' para normalizar a data
        const today = new Date();
        today.setHours(0, 0, 0, 0); // Zerar horas para comparar apenas a data

        // Verifica se a data selecionada está no passado
        if (selectedDate < today) {
            alert('A data selecionada não pode ser no passado.');
            eventDateField.value = '';
            return; // Retorna para evitar mais validações
        }

        validateDayOfWeek();
    }

    // Função para validar o dia da semana com base no tipo de evento selecionado
    function validateDayOfWeek() {
        if (!eventDateField.value) {
            return; // Se não há data, retorna sem fazer nada
        }

        const selectedDate = new Date(eventDateField.value + 'T00:00');
        const selectedDayIndex = selectedDate.getDay().toString(); // Obter o índice do dia como string
        const selectedOption = eventTypeSelect.options[eventTypeSelect.selectedIndex];
        const daysData = selectedOption.getAttribute('data-days');
        const validDays = daysData ? JSON.parse(daysData) : [];

        if (!validDays.includes(selectedDayIndex)) {
            alert('O dia selecionado não é permitido para o tipo de evento escolhido.');
            eventDateField.value = '';
        }
    }

    eventTypeSelect.addEventListener('change', validateDateInput);
    eventDateField.addEventListener('input', validateDateInput);
});
